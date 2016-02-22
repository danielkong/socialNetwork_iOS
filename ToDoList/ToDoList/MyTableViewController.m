//
//  MyTableViewController.m
//  ToDoList
//
//  Created by Daniel Kong on 2/13/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MyTableViewController.h"
#import "ToDoEntity.h"
#import "MyTableViewCell.h"
#import "MyToDoEntityHandler.h"

@interface MyTableViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *resultsController;

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializedNSFetchedResultsControllerDelegate];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)initializedNSFetchedResultsControllerDelegate {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE", nil]; // no grouping
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"todoTitle" // toDoTitle cause crash here.
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    self.resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.resultsController.delegate = self;
    
    NSError *error = nil;
    BOOL fetchSucceeded = [self.resultsController performFetch:&error];
    if (!fetchSucceeded) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"couldnot fetch" userInfo:nil];
    }
//    NSArray *fetchedObjects = [<#context#> executeFetchRequest:fetchRequest error:&error];
//    if (fetchedObjects == nil) {
//        <#Error handling code#>
//    }
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsController.sections[section].numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoEntity *item = self.resultsController.sections[indexPath.section].objects[indexPath.row];
    
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"tableCellIdentifier" forIndexPath:indexPath];
    
    [cell setInternalFields:item];

    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeUpdate: {
            MyTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            ToDoEntity *item = [controller objectAtIndexPath:indexPath];
            [cell setInternalFields:item];
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // pass selected item to view controller
    id<MyContextManagerHandler, MyToDoEntityHandler> child = (id<MyContextManagerHandler, MyToDoEntityHandler>)[segue destinationViewController];
    [child receivedMOC:self.managedObjectContext];
    
//    // step 5:
//    ToDoEntity *item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
//    [child receivedToDoEntity:item];
    
    // step 6: add editing, detect where is it from + or edit
    if ([sender isMemberOfClass:[UIBarButtonItem class]]) {
        // step 5:
        ToDoEntity *item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:self.managedObjectContext];
        [child receivedToDoEntity:item];

    } else {
        MyTableViewCell * source = (MyTableViewCell *)sender;
        ToDoEntity *item = source.localEntity;
        [child receivedToDoEntity:item];

    }
    
}

-(void)receivedMOC:(NSManagedObjectContext *)incomming {
    self.managedObjectContext = incomming;
    //    id<MyContextManagerHandler> child = (id<MyContextManagerHandler> )self.viewControllers[0];
    //    [child receivedMOC:self.managedObjectContext];
};

@end
