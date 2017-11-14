//
//  JETAppDelegate.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETAppDelegate.h"
#import "JETSignInFormViewController.h"
#import "JETSettingsViewController.h"
#import "JETProfileViewController.h"
#import "JETHomeViewContainerViewController.h"

@interface JETAppDelegate ()

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) JETSettingsViewController *settingsVC;
@property (strong, nonatomic) JETProfileViewController *editProfileVC;
@property (strong, nonatomic) JETHomeViewContainerViewController *homeContainerVC;

@end

@implementation JETAppDelegate

// provide the end point of API requests
static NSString *const kEndPointUrl = @"";

static NSString *const kEndPointUrlKey = @"endPointUrl";
static NSString *const kHomeTabBarItemTitle = @"Home";
static NSString *const kProfileTabBarItemTitle = @"Profile";
static NSString *const kSettingsTabBarItemTitle = @"Settings";
static NSString *const kModelName = @"ProjectMatcher";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:kEndPointUrl forKey:kEndPointUrlKey];
    JETSignInFormViewController *signInFormVC = [[JETSignInFormViewController alloc]init];
    UINavigationController *navigationController =
                                            [[UINavigationController alloc]initWithRootViewController:signInFormVC];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)loadHomePage {
    CGFloat tabBarTitlePosition = -14;
    self.tabBarController = [[UITabBarController alloc]init];
    self.homeContainerVC = [[JETHomeViewContainerViewController alloc]init];
    UINavigationController *homeNavigationController =
                                        [[UINavigationController alloc]initWithRootViewController:self.homeContainerVC];
    self.editProfileVC = [[JETProfileViewController alloc]init];
    UINavigationController *profileNavigationController =
                                        [[UINavigationController alloc]initWithRootViewController:self.editProfileVC];
    self.settingsVC = [[JETSettingsViewController alloc]init];
    UINavigationController *settingsNavigationController =
                                            [[UINavigationController alloc]initWithRootViewController:self.settingsVC];
    [self.tabBarController setViewControllers:@[homeNavigationController,
                                                profileNavigationController,
                                                settingsNavigationController]];
    [homeNavigationController.tabBarItem setTitle:kHomeTabBarItemTitle];
    [homeNavigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, tabBarTitlePosition)];
    [profileNavigationController.tabBarItem setTitle:kProfileTabBarItemTitle];
    [profileNavigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, tabBarTitlePosition)];
    [settingsNavigationController.tabBarItem setTitle:kSettingsTabBarItemTitle];
    [settingsNavigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, tabBarTitlePosition)];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:kModelName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ProjectMatcher.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:options
                                                           error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // TODO: Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate.
        // You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // TODO: Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate.
            // You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
