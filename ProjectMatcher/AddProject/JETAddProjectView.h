//
//  JETAddProjectView.h
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JETAddProjectView : UIView

@property (strong, nonatomic) UITextField *projectNameTextField;
@property (strong, nonatomic) UITextView *projectDescriptionTextView;
@property (strong, nonatomic) UITextView *projectSkillsTextView;
@property (strong, nonatomic) UIButton *addProjectButton;

@end
