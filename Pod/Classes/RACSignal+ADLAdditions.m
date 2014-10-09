//
// Created by Alex Manarpies on 16/09/14.
// Copyright (c) 2014 Ace on Tech. All rights reserved.
//

#import "RACSignal+ADLAdditions.h"
#import "RACScheduler.h"
#import "RACSubscriber.h"

@implementation RACSignal (ADLAdditions)

+ (RACSignal *)adl_createSignalOnScheduler:(RACScheduler *)scheduler withBlock:(ABTMSignalBlock)block {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
        return [scheduler schedule:^{
            block(subscriber);
        }];
    }];
}

+ (RACSignal *)adl_createSignalOnBackgroundSchedulerWithBlock:(ABTMSignalBlock)block {
    return [self adl_createSignalOnScheduler:[RACScheduler scheduler] withBlock:block];
}

@end