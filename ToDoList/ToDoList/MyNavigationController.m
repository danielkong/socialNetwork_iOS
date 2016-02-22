//
//  MyNavigationController.m
//  ToDoList
//
//  Created by Daniel Kong on 2/13/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
@implementation MyNavigationController



-(void)receivedMOC:(NSManagedObjectContext *)incomming {
    self.managedObjectContext = incomming;
    id<MyContextManagerHandler> child = (id<MyContextManagerHandler> )self.viewControllers[0];
    [child receivedMOC:self.managedObjectContext];
};

@end
