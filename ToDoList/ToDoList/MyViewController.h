//
//  MyViewController.h
//  ToDoList
//
//  Created by Daniel Kong on 2/13/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyContextManagerHandler.h"
#import "MyToDoEntityHandler.h"

@interface MyViewController : UIViewController<MyContextManagerHandler, MyToDoEntityHandler>

- (void)receivedMOC:(NSManagedObjectContext *)incomming; // view controller
- (void)receivedToDoEntity:(ToDoEntity *)ToDoEntity;     // detail view controller

@end
