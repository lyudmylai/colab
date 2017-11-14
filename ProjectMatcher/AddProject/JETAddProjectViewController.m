//
//  JETAddProjectViewController.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETAddProjectViewController.h"
#import "JETAddProjectView.h"
#import "JETAppDelegate.h"
#import "ProjectMatcher+CoreDataModel.h"

@interface JETAddProjectViewController () <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController <Project *> *projectFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController <Skill *> *skillFetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) JETAddProjectView *addProjectView;

@end

@implementation JETAddProjectViewController

static NSString *const kViewControllerTitle = @"Add New Project";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addProjectView = [[JETAddProjectView alloc]initWithFrame:self.view.frame];
    self.view = self.addProjectView;
    [self setTitle:kViewControllerTitle];
    [self.addProjectView.addProjectButton addTarget:self
                                             action:@selector(onAddProjectButtonTapped:)
                                   forControlEvents:UIControlEventTouchUpInside];
}

- (void)onAddProjectButtonTapped:(id)sender {
    [self createNewProject];
}

- (void)createNewProject {
    NSManagedObjectContext *context = [self.projectFetchedResultsController managedObjectContext];
    Project *newProjectObject = [NSEntityDescription insertNewObjectForEntityForName:@"Project"
                                                       inManagedObjectContext:self.managedObjectContext];
    NSString *stringUUID = [[NSUUID UUID]UUIDString];
    newProjectObject.projectId = stringUUID;
    newProjectObject.projectCreationDate = [NSDate date];
    if (self.addProjectView.projectNameTextField.text && (self.addProjectView.projectNameTextField.text.length > 0)) {
        newProjectObject.projectTitle = self.addProjectView.projectNameTextField.text;
    }

    NSError *saveError = nil;
    if (![context save:&saveError]) {
        NSLog(@"Cannot save project with error %@, %@", saveError, saveError.userInfo);
    }

    NSString *skillsAsString = self.addProjectView.projectSkillsTextView.text;
    NSArray *skills = nil;
    if (skillsAsString && (skillsAsString.length > 0)) {
        skills = [skillsAsString componentsSeparatedByString:@","];
    }

    if (skills && (skills.count > 0)) {
        for (NSString *skillAsString in skills) {
            Skill *newSkill = [NSEntityDescription insertNewObjectForEntityForName:@"Skill"
                                                            inManagedObjectContext:context];
            newSkill.skillId = [[NSUUID UUID]UUIDString];
            newSkill.skillName = skillAsString;
        }
    }
    if (![context save:&saveError]) {
        NSLog(@"Cannot save skills with error %@, %@", saveError, saveError.userInfo);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController<Project *> *)projectFetchedResultsController {
    NSFetchRequest<Project *> *fetchRequest = Project.fetchRequest;

    [fetchRequest setReturnsObjectsAsFaults:NO];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"projectCreationDate" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];

    if (self.managedObjectContext == nil) {
        JETAppDelegate *appDelegate = (JETAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }

    NSFetchedResultsController<Project *> *projectFetchedResultsController =
                                    [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                       managedObjectContext:self.managedObjectContext
                                                                         sectionNameKeyPath:nil
                                                                                  cacheName:nil];
    projectFetchedResultsController.delegate = self;

    NSError *error = nil;
    if (![projectFetchedResultsController performFetch:&error]) {
        NSLog(@"Cannot fetch projects %@, %@", error, error.userInfo);
    }

    _projectFetchedResultsController = projectFetchedResultsController;
    return _projectFetchedResultsController;
}

- (NSFetchedResultsController<Skill *> *)skillFetchedResultsController {
    NSFetchRequest<Skill *> *fetchRequest = Skill.fetchRequest;

    [fetchRequest setReturnsObjectsAsFaults:NO];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"skillId" ascending:NO];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];

    if (self.managedObjectContext == nil) {
        JETAppDelegate *appDelegate = (JETAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.managedObjectContext = appDelegate.managedObjectContext;
    }

    NSFetchedResultsController<Skill *> *skillFetchedResultsController =
                                    [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                       managedObjectContext:self.managedObjectContext
                                                                         sectionNameKeyPath:nil
                                                                                  cacheName:nil];
    skillFetchedResultsController.delegate = self;

    NSError *error = nil;
    if (![skillFetchedResultsController performFetch:&error]) {
        NSLog(@"Cannot fetch skills %@, %@", error, error.userInfo);
    }

    _skillFetchedResultsController = skillFetchedResultsController;
    return _skillFetchedResultsController;
}

@end
