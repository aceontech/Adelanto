//
// Created by Alex Manarpies on 09/10/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ADLUpdateButton : UIButton

@property(nonatomic, strong) NSString *updateAvailableTitle;
@property(nonatomic, strong) NSString *updateAvailableMessage; // Takes 2 %@ format specifiers (nextVersion, currentVersion)
@property(nonatomic, strong) NSString *skipVersionButtonTitle;
@property(nonatomic, strong) NSString *yesButtonTitle;
@property(nonatomic, strong) NSString *noButtonTitle;
@property(nonatomic, strong) NSString *upToDateTitle;
@property(nonatomic, strong) NSString *upToDateMessage;
@property(nonatomic, strong) NSString *okButtonTitle;

#pragma mark - Designated Initializers

- (instancetype)initWithUpdateCentralURL:(NSURL *)updateCentralURL;

+ (instancetype)buttonWithUpdateCentralURL:(NSURL *)updateCentralURL;

@end