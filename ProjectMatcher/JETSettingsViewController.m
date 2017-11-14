//
//  JETSettingsViewController.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETSettingsViewController.h"

@interface JETSettingsViewController ()

@end

@implementation JETSettingsViewController

static NSString *const kViewControllerTitle = @"Settings";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:kViewControllerTitle];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

@end
