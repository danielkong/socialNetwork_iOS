//
//  MyTableViewCell.m
//  ToDoList
//
//  Created by Daniel Kong on 2/20/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)setInternalFields:(ToDoEntity *)incommingEntity {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];

    
    self.toDoTitleLabel.text = incommingEntity.todoTitle;
    self.localEntity = incommingEntity;
    self.toDoDueDateLabel.text = [dateFormatter stringFromDate:incommingEntity.todoDueDate];
}

@end
