//
//  MyViewController.m
//  ToDoList
//
//  Created by Daniel Kong on 2/13/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import "MyViewController.h"


@interface MyViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) ToDoEntity *localToDoEntity;
@property (nonatomic, assign) BOOL wasDeleted;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *detailView;
@property (weak, nonatomic) IBOutlet UIDatePicker *dueDateField;

@end

@implementation MyViewController

- (void)saveMyToDoEntity {
    NSError *err;
    BOOL saveSuccess = [self.managedObjectContext save:&err];
    if (!saveSuccess) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"could not save entity" userInfo:@{NSUnderlyingErrorKey:err}];
    }
}

-(void)receivedMOC:(NSManagedObjectContext *)incomming {
    self.managedObjectContext = incomming;
    //    id<MyContextManagerHandler> child = (id<MyContextManagerHandler> )self.viewControllers[0];
    //    [child receivedMOC:self.managedObjectContext];
};

- (void)receivedToDoEntity:(ToDoEntity *)ToDoEntity {
    self.localToDoEntity = ToDoEntity;
}

- (void)textViewDidEndEditing:(NSNotification *)notif {
    if ([notif object] == self) {
        self.localToDoEntity.todoDetails = self.detailView.text;
        [self saveMyToDoEntity];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    //
    self.wasDeleted = NO;
    // setup form
    self.titleField.text = self.localToDoEntity.todoTitle;
    self.detailView.text = self.localToDoEntity.todoDetails;

    NSDate *dueDate = self.localToDoEntity.todoDueDate;
    if (dueDate != nil) {
        [self.dueDateField setDate:dueDate];
    }
    // detect edit ends
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    if (!self.wasDeleted) {
        // save everything since date picker did not saving
        self.localToDoEntity.todoTitle = self.titleField.text;
        self.localToDoEntity.todoDetails = self.detailView.text;
        self.localToDoEntity.todoDueDate = self.dueDateField.date;
        [self saveMyToDoEntity];
    }

    // remove detection
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
}

- (IBAction)titleFieldEdited:(id)sender {
    self.localToDoEntity.todoTitle = self.titleField.text;
    [self saveMyToDoEntity];
}

- (IBAction)dueDateEdited:(id)sender {
    self.localToDoEntity.todoDueDate = self.dueDateField.date;
    [self saveMyToDoEntity];
}

- (IBAction)trashTapped:(id)sender {
    self.wasDeleted = YES;
    [self.managedObjectContext deleteObject:self.localToDoEntity];
    [self saveMyToDoEntity];
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
