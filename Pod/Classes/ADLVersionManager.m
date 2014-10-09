//
// Created by Alex Manarpies on 07/10/14.
//

#import "ADLVersionManager.h"
#import "ADLConstants.h"


@implementation ADLVersionManager

+ (void)saveVersionFromMainBundle {
    [self saveVersionFromMainBundleWithKey:@"adl_appVersion"];
}

+ (void)saveVersionFromMainBundleWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *bundleInfo = [NSBundle mainBundle].infoDictionary;
    NSString *version = [NSString stringWithFormat:@"%@ build %@", bundleInfo[ADLBundleVersionNumberKey], bundleInfo[ADLBundleBuildNumberKey]];
    [defaults setValue:version forKey:key];
    [defaults synchronize];
}

@end