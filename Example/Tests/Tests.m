//
//  AdelantoTests.m
//  AdelantoTests
//
//  Created by Alex Manarpies on 10/07/2014.
//  Copyright (c) 2014 Alex Manarpies. All rights reserved.
//

#import "ADLUpdateManager.h"
#import "RACSignal+Operations.h"
#import "RACScheduler.h"
#import "ADLUpdate.h"

SpecBegin(UpdateManager)

        describe(@"update manager", ^{
            __block ADLUpdateManager *manager;

            before(^{
                manager = [ADLUpdateManager managerWithUpdateCentralURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/aceontech/Adelanto/master/UpdateCentralExample/adl_central.plist"]];
            });

            it(@"should report new version (signals)", ^AsyncBlock {
                [[[[manager checkForUpdates]
                        deliverOn:[RACScheduler mainThreadScheduler]]
                        doNext:^(ADLUpdate *update) {
                            expect(update).notTo.beNil();
                            expect(update).to.beKindOf([ADLUpdate class]);
                            done();
                        }]
                        subscribeError:^(NSError *error) {
                            expect(error).to.beNil();
                            done();
                        }];
            });
        });

SpecEnd
