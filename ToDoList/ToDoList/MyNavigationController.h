//
//  MyNavigationController.h
//  ToDoList
//
//  Created by Daniel Kong on 2/13/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyContextManagerHandler.h"

@interface MyNavigationController : UINavigationController <MyContextManagerHandler>

-(void)receivedMOC:(NSManagedObjectContext *)incomming;


@end
