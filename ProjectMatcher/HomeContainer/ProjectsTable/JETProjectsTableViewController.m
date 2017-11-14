//
//  JETProjectsTableViewController.m
//  ProjectMatcher
//
//  Created by Lyudmyla Ivanova on 11/10/17.
//  Copyright © 2017 Lyudmyla Ivanova. All rights reserved.
//

#import "JETProjectsTableViewController.h"
#import "JETProjectTableViewCell.h"
#import "JETAppDelegate.h"
#import "ProjectMatcher+CoreDataModel.h"

@interface JETProjectsTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController <Project *> *projectFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController <Skill *> *skillFetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation JETProjectsTableViewController

static NSString *const kViewControllerTitle = @"History";
static NSString *const kCellReuseIdentifier = @"historyItemCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:kViewControllerTitle];
    [self.tableView registerClass:[JETProjectTableViewCell class]forCellReuseIdentifier:kCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.projectFetchedResultsController = nil;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectFetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JETProjectTableViewCell *cell =
    (JETProjectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier
                                                                forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JETProjectTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:kCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Project *projectObject = [self.projectFetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.projectNameLabel.text = projectObject.projectTitle;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ceil(self.tableView.frame.size.height / 2 - 50);
}

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

@end
