//
//  ToDoEntity+CoreDataProperties.h
//  ToDoList
//
//  Created by Daniel Kong on 2/20/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDoEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *todoTitle;
@property (nullable, nonatomic, retain) NSString *todoDetails;
@property (nullable, nonatomic, retain) NSDate *todoDueDate;

@end

NS_ASSUME_NONNULL_END
