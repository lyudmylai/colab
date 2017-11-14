//
//  JETHomeViewContainerViewController.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETHomeViewContainerViewController.h"
#import "JETProfilesCollectionViewController.h"
#import "JETProjectsTableViewController.h"
#import "JETAddProjectViewController.h"

@interface JETHomeViewContainerViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *searchTextField;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) JETProfilesCollectionViewController *profilesCollectionVC;
@property (strong, nonatomic) JETProjectsTableViewController *projectsTableVC;
@property (assign, nonatomic) CGFloat topInset;

@end

@implementation JETHomeViewContainerViewController

static NSString *const kViewControllerTitle = @"Home";
static NSString *const kSearchButtonTitle = @"Search";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:kViewControllerTitle];
    self.view.backgroundColor = [UIColor darkGrayColor];
    self.topInset = [UIApplication sharedApplication].statusBarFrame.size.height +
                                                        self.navigationController.navigationBar.frame.size.height;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.profilesCollectionVC = [[JETProfilesCollectionViewController alloc]
                                            initWithCollectionViewLayout:layout];
    [self addChildViewController:self.profilesCollectionVC];
    [self.view addSubview:self.profilesCollectionVC.view];
    [self.profilesCollectionVC didMoveToParentViewController:self];

    self.projectsTableVC = [[JETProjectsTableViewController alloc]init];
    [self addChildViewController:self.projectsTableVC];
    [self.view addSubview:self.projectsTableVC.view];
    [self.projectsTableVC didMoveToParentViewController:self];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                              target:self
                                                                              action:@selector(addNewRecord:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)viewWillLayoutSubviews {
    if (!self.searchButton) {
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.searchButton.userInteractionEnabled = YES;
        [self.searchButton addTarget:self action:@selector(onSearchButtonTapped:)
                     forControlEvents:UIControlEventTouchUpInside];
        [self.searchButton setTitle:kSearchButtonTitle forState:UIControlStateNormal];
        self.searchButton.frame = CGRectZero;
        self.searchTextField = [[UITextField alloc]initWithFrame:CGRectZero];
        NSUInteger height = MAX([self.searchButton sizeThatFits:self.searchButton.frame.size].height,
                                [self.searchTextField sizeThatFits:self.searchTextField.frame.size].height);
        self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width -
                                    [self.searchButton sizeThatFits:self.searchButton.frame.size].width - 40, height)];
        [self.searchButton setFrame:CGRectMake(self.searchTextField.frame.size.width + 20, 20,
                                       [self.searchButton sizeThatFits:self.searchButton.frame.size].width, height)];
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topInset, self.view.frame.size.width,
                                                                         height + 40)];
        [backgroundView addSubview:self.searchTextField];
        [backgroundView addSubview:self.searchButton];
        [self.view addSubview:backgroundView];
        [self.profilesCollectionVC.view setFrame:CGRectMake(0, CGRectGetMaxY(backgroundView.frame),
                                                            self.view.frame.size.width,
                                                            self.view.frame.size.height / 4)];
        [self.projectsTableVC.view setFrame:CGRectMake(0, CGRectGetMaxY(self.profilesCollectionVC.view.frame),
                                                       self.view.frame.size.width,
                                                       self.view.frame.size.height -
                                                       CGRectGetMaxY(self.profilesCollectionVC.view.frame))];
        self.searchTextField.layer.cornerRadius = 5;
        self.searchTextField.clipsToBounds = YES;
        self.searchTextField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_icon.png"]];
        self.searchTextField.leftViewMode = UITextFieldViewModeAlways;
        self.searchTextField.opaque = YES;
        self.searchTextField.placeholder = @"Search...";
        self.searchTextField.backgroundColor = [UIColor whiteColor];
        [self.searchTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        self.searchTextField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        self.searchTextField.returnKeyType = UIReturnKeyDone;
        self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.searchTextField.delegate = self;
    }
}

- (void)dealloc {
    [self.profilesCollectionVC willMoveToParentViewController:nil];
    [self.profilesCollectionVC.view removeFromSuperview];
    [self.profilesCollectionVC removeFromParentViewController];

    [self.projectsTableVC willMoveToParentViewController:nil];
    [self.projectsTableVC.view removeFromSuperview];
    [self.projectsTableVC removeFromParentViewController];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    if ([textField isEqual:self.searchTextField]) {
        // start search query
    }
    return YES;
}

- (void)onSearchButtonTapped:(id)sender {
    // start search query
}

- (void)addNewRecord:(id)sender {
    JETAddProjectViewController *addProjectVC = [[JETAddProjectViewController alloc]init];
    [self.navigationController pushViewController:addProjectVC animated:YES];
}

@end
