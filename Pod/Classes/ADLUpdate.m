//
// Created by Alex Manarpies on 08/10/14.
//

#import "ADLUpdate.h"


@implementation ADLUpdate

- (instancetype)initWithCurrentVersion:(NSString *)currentVersion nextVersion:(NSString *)newVersion url:(NSURL *)url {
    self = [super init];
    if (self) {
        self.currentVersion = currentVersion;
        self.nextVersion = newVersion;
        self.url = url;
    }
    return self;
}

+ (instancetype)updateWithCurrentVersion:(NSString *)currentVersion newVersion:(NSString *)newVersion url:(NSURL *)url {
    return [[self alloc] initWithCurrentVersion:currentVersion nextVersion:newVersion url:url];
}

- (BOOL)isAvailable {
    return self.nextVersion != nil;
}

@end