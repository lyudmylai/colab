//
//  JETProfilesCollectionViewController.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETProfilesCollectionViewController.h"
#import "JETProfileCollectionViewCell.h"

@interface JETProfilesCollectionViewController ()

@end

@implementation JETProfilesCollectionViewController

static NSString * const kCellReuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[JETProfileCollectionViewCell class]
            forCellWithReuseIdentifier:kCellReuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JETProfileCollectionViewCell *cell =
            (JETProfileCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier
                                                                                      forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.height - 8, self.collectionView.frame.size.height - 16 * 2);
}

@end
