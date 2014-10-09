//
// Created by Alex Manarpies on 08/10/14.
//

#import <Foundation/Foundation.h>


@interface ADLUpdate : NSObject

@property(nonatomic, strong) NSString *currentVersion;
@property(nonatomic, strong) NSString *nextVersion;
@property(nonatomic, strong) NSURL *url;
@property(nonatomic, readonly, getter=isAvailable) BOOL available;

- (instancetype)initWithCurrentVersion:(NSString *)currentVersion nextVersion:(NSString *)newVersion url:(NSURL *)url;

+ (instancetype)updateWithCurrentVersion:(NSString *)currentVersion newVersion:(NSString *)newVersion url:(NSURL *)url;

@end