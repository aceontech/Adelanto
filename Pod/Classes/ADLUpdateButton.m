//
// Created by Alex Manarpies on 09/10/14.
//

#import "ADLUpdateButton.h"
#import "ADLUpdateManager.h"
#import "ADLUpdate.h"

#import <EXTScope.h>
#import <ReactiveCocoa.h>

@interface ADLUpdateButton ()
@property(nonatomic, strong) ADLUpdateManager *updateManager;
@end

@implementation ADLUpdateButton

#pragma mark - Initializers

- (instancetype)initWithUpdateCentralURL:(NSURL *)updateCentralURL {
    self = [[self class] buttonWithType:UIButtonTypeRoundedRect];
    if (self) {
        // Set up update manager
        self.updateManager = [ADLUpdateManager managerWithUpdateCentralURL:updateCentralURL];

        // Handle button taps
        @weakify(self)
        self.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self)

            return [[[self.updateManager checkForUpdates] deliverOn:[RACScheduler mainThreadScheduler]] doNext:^(ADLUpdate *update) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];

                if (update.isAvailable) {
                    alert.title = self.updateAvailableTitle ?: @"Update Available";
                    alert.message = [NSString stringWithFormat:self.updateAvailableMessage ?: @"Version %@ is available\n (currently %@)\n\nUpgrade now?", update.nextVersion, update.currentVersion];
                    [alert addButtonWithTitle:self.skipVersionButtonTitle ?: @"Skip version"];
                    [alert addButtonWithTitle:self.yesButtonTitle ?: @"Yes"];
                    [alert addButtonWithTitle:self.noButtonTitle ?: @"No"];
                } else {
                    alert.title = self.upToDateTitle ?: @"Up to date";
                    alert.message = self.upToDateMessage ?: @"You are currently on the latest version.";
                    [alert addButtonWithTitle:self.okButtonTitle ?: @"OK"];
                }

                [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *index) {
                    @strongify(self)

                    if (update.isAvailable) {
                        switch (index.integerValue) {
                            case 0: // SKIP
                                [self.updateManager skipVersionNumber:update.nextVersion];
                                break;

                            case 1: // YES
                                [self.updateManager installUpdate:update];
                                break;

                            default:
                                // Do nothing
                                break;
                        }
                    }
                }];

                [alert show];
            }];
        }];

    }

    return self;
}

+ (instancetype)buttonWithUpdateCentralURL:(NSURL *)updateCentralURL {
    return [[self alloc] initWithUpdateCentralURL:updateCentralURL];
}

@end