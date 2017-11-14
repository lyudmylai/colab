//
//  JETSignInFormView.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETSignInFormView.h"

@interface JETSignInFormView ()

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *mainContentView;
@property (strong, nonatomic) UILabel *usernameLabel;
@property (strong, nonatomic) UILabel *passwordLabel;
@property (strong, nonatomic) UIView *usernameContainerView;
@property (strong, nonatomic) UIView *passwordContainerView;
@property (strong, nonatomic) UIView *buttonsContainer;

@property (nonatomic) CGSize viewSize;
@property (nonatomic) UIEdgeInsets edgeInsets;

@end

@implementation JETSignInFormView

static NSString *const kUsernameLabelText = @"User name";
static NSString *const kPasswordLabelText = @"Password";
static NSString *const kUsernameTextfieldPlaceholder = @"Your username...";
static NSString *const kPasswordTextfieldPlaceholder = @"Password...";
static NSString *const kLoginButtonName = @"Log In";
static NSString *const kSignUpButtonName = @"Sign Up";
static CGFloat const kEdgeInset = 16;

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    if (self) {
        self.viewSize = aRect.size;
        self.edgeInsets = UIEdgeInsetsMake(16, 20, 16, 20);
        self.backgroundColor = [UIColor darkGrayColor];
        [self createContainerView];
        [self addUsernameSubviews];
        [self addPasswordSubviews];
        [self configureContainerView];
        [self addSignUpButton];
        [self addLogInButton];
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

- (void)addUsernameSubviews {
    self.usernameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self setUpLabel:self.usernameLabel
            withText:kUsernameLabelText
widthAdjustedForText:kPasswordLabelText];
    CGFloat textfieldHeight = 30;
    CGFloat space = 20;
    CGSize textfieldSize = CGSizeMake(self.viewSize.width - (self.edgeInsets.left + self.edgeInsets.right)
                                      - self.usernameLabel.frame.size.width - space, textfieldHeight);
    CGPoint position = CGPointMake(self.usernameLabel.frame.size.width + self.edgeInsets.left + space, 0);
    self.usernameTextfield = [[UITextField alloc]initWithFrame:CGRectZero];
    [self setUpTextField:self.usernameTextfield
                    size:textfieldSize
                position:position
             placeholder:kUsernameTextfieldPlaceholder
                  secure:NO
       keyboardReturnKey:UIReturnKeyNext];
    CGFloat subviewHeight = MAX(self.usernameLabel.frame.size.height, self.usernameTextfield.frame.size.height) +
    self.edgeInsets.top + self.edgeInsets.bottom;
    self.usernameContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, kEdgeInset, self.frame.size.width,
                                                                         subviewHeight)];
    [self.usernameLabel setFrame:CGRectMake(self.edgeInsets.left, self.edgeInsets.top,
                                            self.usernameLabel.frame.size.width, self.usernameLabel.frame.size.height)];
    [self.usernameTextfield setFrame:CGRectMake(self.edgeInsets.left + self.usernameLabel.frame.size.width + space,
                                                self.edgeInsets.top, self.usernameTextfield.frame.size.width,
                                                self.usernameTextfield.frame.size.height)];
    [self.usernameLabel setCenter:CGPointMake(self.usernameLabel.center.x, self.usernameTextfield.center.y)];
    [self.usernameContainerView addSubview:self.usernameLabel];
    [self.usernameContainerView addSubview:self.usernameTextfield];
    [self.mainContentView addSubview:self.usernameContainerView];
}

- (void)addPasswordSubviews {
    self.passwordLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    [self setUpLabel:self.passwordLabel
            withText:kPasswordLabelText
widthAdjustedForText:kUsernameLabelText];
    CGFloat textfieldHeight = 30;
    CGFloat space = 20;
    CGSize textfieldSize = CGSizeMake(self.viewSize.width - (self.edgeInsets.left + self.edgeInsets.right)
                                      - self.passwordLabel.frame.size.width - space, textfieldHeight);
    CGPoint position = CGPointMake(self.passwordLabel.frame.size.width + self.edgeInsets.left + space, 0);
    self.passwordTextfield = [[UITextField alloc]initWithFrame:CGRectZero];
    [self setUpTextField:self.passwordTextfield
                    size:textfieldSize
                position:position
             placeholder:kPasswordTextfieldPlaceholder
                  secure:YES
       keyboardReturnKey:UIReturnKeyDone];
    CGFloat subviewHeight = MAX(self.passwordLabel.frame.size.height, self.passwordTextfield.frame.size.height) +
    self.edgeInsets.top + self.edgeInsets.bottom;
    self.passwordContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.usernameContainerView.frame.origin.y +
                                                                         self.usernameContainerView.frame.size.height,
                                                                         self.frame.size.width, subviewHeight)];
    [self.passwordLabel setFrame:CGRectMake(self.edgeInsets.left, self.edgeInsets.top,
                                            self.passwordLabel.frame.size.width, self.passwordLabel.frame.size.height)];
    [self.passwordTextfield setFrame:CGRectMake(self.edgeInsets.left + self.passwordLabel.frame.size.width +
                                                space, self.edgeInsets.top, self.passwordTextfield.frame.size.width,
                                                self.passwordTextfield.frame.size.height)];
    [self.passwordLabel setCenter:CGPointMake(self.passwordLabel.center.x, self.passwordTextfield.center.y)];
    [self.passwordContainerView addSubview:self.passwordLabel];
    [self.passwordContainerView addSubview:self.passwordTextfield];
    [self.mainContentView addSubview:self.passwordContainerView];
}

- (void)setUpLabel:(UILabel *)label
          withText:(NSString *)text
widthAdjustedForText:(NSString *)alignedLabelText {
    CGFloat fontSize = 16.0;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    CGSize labelSize;
    if (alignedLabelText) {
        CGSize comparizonSize = [alignedLabelText sizeWithAttributes:@{NSFontAttributeName:
                                                                           [UIFont systemFontOfSize:fontSize]}];
        labelSize = CGSizeMake(MAX(ceilf(size.width), ceil(comparizonSize.width)), ceilf(size.height));
    } else {
        labelSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    }

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

- (void)addSignUpButton {
    self.signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [self.signUpButton sizeThatFits:self.signUpButton.frame.size];
    [self.signUpButton setFrame:CGRectMake(kEdgeInset, CGRectGetMaxY(self.passwordContainerView.frame) + kEdgeInset,
                                          self.frame.size.width / 2 - 3 * kEdgeInset,
                                          ceil(size.height))];
    [self.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signUpButton setTitle:kSignUpButtonName forState:UIControlStateNormal];
    self.signUpButton.userInteractionEnabled = YES;
    self.signUpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    [self.signUpButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.mainContentView addSubview:self.signUpButton];
    [self.mainContentView setFrame:CGRectMake(self.mainContentView.frame.origin.x,
                                              self.mainContentView.frame.origin.y,
                                              self.mainContentView.frame.size.width,
                                              CGRectGetMaxY(self.signUpButton.frame))];
}

- (void)addLogInButton {
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGSize size = [self.loginButton sizeThatFits:self.loginButton.frame.size];
    [self.loginButton setFrame:CGRectMake(self.frame.size.width / 2 + kEdgeInset,
                                          CGRectGetMaxY(self.passwordContainerView.frame) + kEdgeInset,
                                          self.frame.size.width / 2 - 3 * kEdgeInset,
                                          ceil(size.height))];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:kLoginButtonName forState:UIControlStateNormal];
    self.loginButton.userInteractionEnabled = YES;
    self.loginButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.mainContentView addSubview:self.loginButton];
    [self.mainContentView setFrame:CGRectMake(self.mainContentView.frame.origin.x,
                                              self.mainContentView.frame.origin.y,
                                              self.mainContentView.frame.size.width,
                                              CGRectGetMaxY(self.loginButton.frame))];
}

@end
