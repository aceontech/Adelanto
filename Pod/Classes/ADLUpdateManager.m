//
// Created by Alex Manarpies on 07/10/14.
//

#import "ADLUpdateManager.h"
#import "ADLConstants.h"
#import "RACSignal+ADLAdditions.h"
#import "ADLUpdate.h"

#import <ReactiveCocoa.h>
#import <EXTScope.h>

static NSString *const kADLSkippedVersionNumberKey = @"ADLSkippedVersionNumber";

@interface ADLUpdateManager ()

// Public
@property(nonatomic, strong, readwrite) NSURL *updateCentralURL;

// Private
@property(nonatomic, strong, readonly) NSDictionary *bundleInfo;

@end

@implementation ADLUpdateManager

- (NSDictionary *)bundleInfo {
    return [NSBundle mainBundle].infoDictionary;
}

#pragma mark - Initializers

- (instancetype)initWithUpdateCentralURL:(NSURL *)updateCentralURL {
    self = [super init];
    if (self) {
        self.updateCentralURL = updateCentralURL;
    }
    return self;
}

+ (instancetype)managerWithUpdateCentralURL:(NSURL *)updateCentralURL {
    return [[self alloc] initWithUpdateCentralURL:updateCentralURL];
}

#pragma mark - API

- (RACSignal *)checkForUpdates {
    @weakify(self)
    return [[self loadUpdateCentral]
            flattenMap:^RACStream *(NSDictionary *updateCentral) {
                @strongify(self)
                NSString *bundleIdentifier = self.bundleInfo[ADLBundleIdentifierKey];
                NSString *plistURLString = updateCentral[bundleIdentifier];
                return [self checkPlistURLString:plistURLString];
            }];
}

- (void)skipVersionNumber:(NSString *)versionNumber {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:versionNumber forKey:kADLSkippedVersionNumberKey];
    [defaults synchronize];
}

- (void)installUpdate:(ADLUpdate *)update {
    if (update.isAvailable) {
        // Request OS to open the install URL
        [[UIApplication sharedApplication] openURL:update.url];

        // Quit app so the update can start installing immediately.
        // Not doing this will stall the installation until the user closes the app.
        exit(EXIT_SUCCESS);
    }
}


#pragma mark - Internal

- (NSString *)getSkippedVersion {
    NSString *skippedVersionNumber = [[NSUserDefaults standardUserDefaults] stringForKey:kADLSkippedVersionNumberKey];
    return skippedVersionNumber;
}

- (RACSignal *)loadUpdateCentral {
    @weakify(self)
    return [RACSignal adl_createSignalOnBackgroundSchedulerWithBlock:^(id <RACSubscriber> subscriber) {
        @strongify(self)

        NSDictionary *updateCentral = [NSDictionary dictionaryWithContentsOfURL:self.updateCentralURL];
        [subscriber sendNext:updateCentral];
        [subscriber sendCompleted];
    }];
}

- (RACSignal *)checkPlistURLString:(NSString *)plistURLString {
    @weakify(self)
    return [RACSignal adl_createSignalOnBackgroundSchedulerWithBlock:^(id <RACSubscriber> subscriber) {
        @strongify(self)

        if (plistURLString) {
            NSDictionary *plist = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:plistURLString]];
            if (plist) {
                // PLIST found, parse its metadata
                NSArray *items = plist[@"items"];
                NSDictionary *itemDict = [items lastObject];
                NSDictionary *metaData = itemDict[@"metadata"];
                NSString *newVersion = [metaData valueForKey:@"bundle-version"];
                NSString *currentVersion = self.bundleInfo[ADLBundleVersionNumberKey];

                // Check for updates
                BOOL updateAvailable = [newVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending;

                // Create update descriptor
                ADLUpdate *update = [[ADLUpdate alloc] init];
                update.currentVersion = currentVersion;

                if (updateAvailable && ![newVersion isEqualToString:self.getSkippedVersion]) {
                    update.nextVersion = newVersion;
                    update.url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@", plistURLString]];
                }

                [subscriber sendNext:update];
                [subscriber sendCompleted];
                return;
            }
        }

        [subscriber sendNext:nil];
        [subscriber sendCompleted];
    }];
}

@end