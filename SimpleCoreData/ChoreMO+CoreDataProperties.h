//
//  ChoreMO+CoreDataProperties.h
//  SimpleCoreData
//
//  Created by Daniel Kong on 1/17/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ChoreMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChoreMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *chore_name;
@property (nullable, nonatomic, retain) ChoreLogMO *chore_log;

@end

NS_ASSUME_NONNULL_END
