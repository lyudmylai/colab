//
//  JETAddProjectView.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETAddProjectView.h"

@interface JETAddProjectView ()

@property (strong, nonatomic) UILabel *projectNameLabel;
@property (strong, nonatomic) UILabel *projectDescriptionLabel;
@property (strong, nonatomic) UILabel *projectSkillsLabel;
@property (strong, nonatomic) UIView *projectNameContainerView;
@property (strong, nonatomic) UIView *projectDescriptionContainerView;
@property (strong, nonatomic) UIView *projectSkillsContainerView;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *mainContentView;

@end

@implementation JETAddProjectView

static NSString *const kProjectNameLabelText = @"Title";
static NSString *const kProjectDescriptionLabelText = @"Description";
static NSString *const kProjectSkillsLabelText = @"Skills";
static NSString *const kProjectNameTextfieldPlaceholder = @"Project title...";
static NSString *const kAddProjectButtonName = @"Add Project";
static CGFloat const kEdgeInset = 16;

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self createContainerView];
        [self addProjectNameSubviews];
        [self addProjectSkillsSubviews];
        [self setupAddButton];
        [self configureContainerView];
    }
    return self;
}

- (void)createContainerView {
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                                                                        self.frame.size.height)];
    self.mainContentView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.mainScrollView addSubview:self.mainContentView];
    [self addSubview:self.mainScrollView];
}

- (void)configureContainerView {
    CGFloat height = CGRectGetMaxY([[self.mainContentView subviews]lastObject].frame);
    [self.mainContentView setFrame:CGRectMake(0, 0, self.frame.size.width, height)];
    self.mainScrollView.contentSize = CGSizeMake(self.mainContentView.frame.size.width,
                                                 self.mainContentView.frame.size.height);
}

- (void)addProjectNameSubviews {
    self.projectNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self setUpLabel:self.projectNameLabel
            withText:kProjectNameLabelText];
    CGFloat textfieldHeight = 30;
    CGFloat space = 20;
    CGSize textfieldSize = CGSizeMake(self.frame.size.width -
                                      self.projectNameLabel.frame.size.width - space, textfieldHeight);
    CGPoint position = CGPointMake(self.projectNameLabel.frame.size.width + space, 0);
    self.projectNameTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    [self setUpTextField:self.projectNameTextField
                    size:textfieldSize
                position:position
             placeholder:kProjectNameTextfieldPlaceholder
                  secure:NO
       keyboardReturnKey:UIReturnKeyNext];
    CGFloat subviewHeight = MAX(self.projectNameLabel.frame.size.height, self.projectNameTextField.frame.size.height);
    self.projectNameContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, kEdgeInset, self.frame.size.width,
                                                                         subviewHeight)];
    [self.projectNameLabel setFrame:CGRectMake(0, 0, self.projectNameLabel.frame.size.width,
                                               self.projectNameLabel.frame.size.height)];
    [self.projectNameTextField setFrame:CGRectMake(0 + self.projectNameLabel.frame.size.width + space,
                                                   0, self.projectNameTextField.frame.size.width - 2 * kEdgeInset,
                                                   self.projectNameTextField.frame.size.height)];
    [self.projectNameLabel setCenter:CGPointMake(self.projectNameLabel.center.x, self.projectNameTextField.center.y)];
    [self.projectNameContainerView setFrame:CGRectMake(kEdgeInset, kEdgeInset, self.frame.size.width,
                                                       MAX(self.projectNameLabel.frame.size.height,
                                                           self.projectNameTextField.frame.size.height))];
    [self.projectNameContainerView addSubview:self.projectNameLabel];
    [self.projectNameContainerView addSubview:self.projectNameTextField];
    [self.mainContentView addSubview:self.projectNameContainerView];
}

- (void)addProjectSkillsSubviews {
    UIFont *textFont = [UIFont boldSystemFontOfSize:20];
    self.projectSkillsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self setUpLabel:self.projectSkillsLabel
            withText:kProjectSkillsLabelText];

    self.projectSkillsTextView =
            [[UITextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.projectSkillsLabel.frame) + kEdgeInset,
                                                        self.frame.size.width - 2 * kEdgeInset, 80)];
    self.projectSkillsTextView.editable = YES;
    self.projectSkillsTextView.scrollEnabled = NO;
    self.projectSkillsTextView.textAlignment = NSTextAlignmentJustified;
    self.projectSkillsTextView.font = textFont;
    self.projectSkillsTextView.backgroundColor = [UIColor whiteColor];
    self.projectSkillsTextView.dataDetectorTypes = UIDataDetectorTypeLink;


    self.projectSkillsContainerView = [[UIView alloc]initWithFrame:CGRectMake(kEdgeInset,
                                                  CGRectGetMaxY(self.projectNameContainerView.frame) + 2 * kEdgeInset,
                                                  self.frame.size.width,
                                                  CGRectGetMaxY(self.projectSkillsTextView.frame) + kEdgeInset)];

    [self.projectSkillsContainerView addSubview:self.projectSkillsLabel];
    [self.projectSkillsContainerView addSubview:self.projectSkillsTextView];
    [self.mainContentView addSubview:self.projectSkillsContainerView];
}

- (void)setupAddButton {
    self.addProjectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [self.addProjectButton sizeThatFits:self.addProjectButton.frame.size];
    [self.addProjectButton setFrame:CGRectMake(self.frame.size.width / 2 + kEdgeInset,
                                          CGRectGetMaxY(self.projectSkillsContainerView.frame) + kEdgeInset,
                                          self.frame.size.width / 2 - 3 * kEdgeInset,
                                          ceil(size.height))];
    [self.addProjectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addProjectButton setTitle:kAddProjectButtonName forState:UIControlStateNormal];
    self.addProjectButton.userInteractionEnabled = YES;
    self.addProjectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    [self.addProjectButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.mainContentView addSubview:self.addProjectButton];
}

- (void)setUpLabel:(UILabel *)label
          withText:(NSString *)text {
    CGFloat fontSize = 16.0;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    CGSize labelSize;

    labelSize = CGSizeMake(ceilf(size.width), ceilf(size.height));

    [label setFrame: CGRectMake(0, 0, labelSize.width, labelSize.height)];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 1;
    label.clipsToBounds = YES;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
}

- (void)setUpTextField:(UITextField *)textfield
                  size:(CGSize)size
              position:(CGPoint)position
           placeholder:(NSString *)text
                secure:(BOOL)isSecure
     keyboardReturnKey:(NSInteger)returnKeyType {
    CGFloat fontSize = 16.0;
    [textfield setFrame:CGRectMake(position.x, position.y, size.width, size.height)];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.font = [UIFont systemFontOfSize:fontSize];
    if (text) {
        textfield.placeholder = text;
    }
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textfield.keyboardType = UIKeyboardTypeDefault;
    textfield.returnKeyType = returnKeyType;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.secureTextEntry = isSecure;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.backgroundColor = [UIColor whiteColor];
}

@end
