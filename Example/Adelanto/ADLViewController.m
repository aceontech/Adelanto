//
//  ADLViewController.m
//  Adelanto
//
//  Created by Alex Manarpies on 10/07/2014.
//  Copyright (c) 2014 Alex Manarpies. All rights reserved.
//

#import "ADLViewController.h"
#import "ADLUpdateButton.h"

@interface ADLViewController ()
@property(nonatomic, strong) ADLUpdateButton *updateButton;
@end

@implementation ADLViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.updateButton = [ADLUpdateButton buttonWithUpdateCentralURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/aceontech/Adelanto/feature/update/UpdateCentralExample/adl_central.plist"]];
    [self.updateButton setTitle:@"Check for updates" forState:UIControlStateNormal];
    self.updateButton.frame = CGRectMake(44, 44, 200, 44);

    // Translate to Dutch
    //    self.updateButton.updateAvailableTitle = @"Update beschikbaar";
    //    self.updateButton.updateAvailableMessage = @"Versie %@ is beschikbaar (huidige versie %@).\n\nWilt u nu upgraden?";
    //    self.updateButton.yesButtonTitle = @"Ja";
    //    self.updateButton.noButtonTitle = @"Neen";
    //    self.updateButton.okButtonTitle = @"Oké";
    //    self.updateButton.skipVersionButtonTitle = @"Versie overslaan";

    [self.view addSubview:self.updateButton];
}

@end
