//
// Created by Alex Manarpies on 07/10/14.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class ADLUpdate;

@interface ADLUpdateManager : NSObject

@property(nonatomic, strong, readonly) NSURL *updateCentralURL;

#pragma mark - Initializers

- (instancetype)initWithUpdateCentralURL:(NSURL *)updateCentralURL;

+ (instancetype)managerWithUpdateCentralURL:(NSURL *)updateCentralURL;

#pragma mark - API

/**
* Signal emits ADLUpdate*.
*/
- (RACSignal *)checkForUpdates;

/**
* User decided to skip this version.
* ADLUpdateManager will not offer this update next time.
*/
- (void)skipVersionNumber:(NSString *)versionNumber;

/**
* Starts the installation process for the given update.
*/
- (void)installUpdate:(ADLUpdate *)update;

@end