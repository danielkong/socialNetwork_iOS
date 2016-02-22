//
//  MyToDoEntityHandler.h
//  ToDoList
//
//  Created by Daniel Kong on 2/13/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoEntity.h"

@protocol MyToDoEntityHandler <NSObject>

-(void)receivedToDoEntity:(ToDoEntity *)ToDoEntity;

@end
