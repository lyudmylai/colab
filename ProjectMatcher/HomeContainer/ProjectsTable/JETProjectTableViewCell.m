//
//  JETProjectTableViewCell.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETProjectTableViewCell.h"

@interface JETProjectTableViewCell ()

@property (strong, nonatomic) UIView *contentContainerView;

@end

@implementation JETProjectTableViewCell

static CGFloat const kInset = 10;
static CGFloat const kInsetSmall = 3;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.projectNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.projectNameLabel.backgroundColor = [UIColor whiteColor];
        self.projectNameLabel.textColor = [UIColor darkGrayColor];
        self.contentContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,
                                                                            self.frame.size.height - 3)];
        self.contentContainerView.backgroundColor = [UIColor whiteColor];
        [self.contentContainerView addSubview:self.projectNameLabel];
        [self addSubview:self.contentContainerView];
    }
    return self;
}

- (void)layoutSubviews {
    [self.contentContainerView setFrame:CGRectMake(kInsetSmall, kInsetSmall, self.frame.size.width - 2 * kInsetSmall,
                                                   self.frame.size.height - 2 * kInsetSmall)];
    [self.projectNameLabel setFrame:CGRectMake(kInset, kInset, self.contentContainerView.frame.size.width - 2 * kInset,
                                               self.contentContainerView.frame.size.height - 2 * kInset)];
}

@end
