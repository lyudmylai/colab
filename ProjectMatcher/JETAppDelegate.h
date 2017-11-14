//
//  JETAppDelegate.h
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface JETAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)loadHomePage;
- (void)saveContext;

@end
