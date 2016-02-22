//
//  MyTableViewCell.h
//  ToDoList
//
//  Created by Daniel Kong on 2/20/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoEntity.h"

@interface MyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *toDoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *toDoDueDateLabel;
@property (strong, nonatomic) ToDoEntity *localEntity;
- (void)setInternalFields:(ToDoEntity *)incommingEntity;

@end
