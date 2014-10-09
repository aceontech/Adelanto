//
// Created by Alex Manarpies on 16/09/14.
// Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACSignal.h"

@class RACScheduler;
@protocol RACSubscriber;

typedef void (^ABTMSignalBlock)(id <RACSubscriber> subscriber);

@interface RACSignal (ADLAdditions)

+ (RACSignal *)adl_createSignalOnScheduler:(RACScheduler *)scheduler withBlock:(ABTMSignalBlock)block;
+ (RACSignal *)adl_createSignalOnBackgroundSchedulerWithBlock:(ABTMSignalBlock)block;

@end