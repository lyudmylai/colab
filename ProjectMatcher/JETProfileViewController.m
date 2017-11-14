//
//  JETEditProfileViewController.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETProfileViewController.h"

@interface JETProfileViewController ()

@end

@implementation JETProfileViewController

static NSString *const kViewControllerTitle = @"Profile";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:kViewControllerTitle];
    self.view.backgroundColor = [UIColor grayColor];
}

@end
