//
//  AppDelegate.h
//  SimpleCoreData
//
//  Created by Daniel Kong on 1/17/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class ChoreLogMO, ChoreMO, PersonMO;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// core data create 
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (ChoreMO *)createChoreMO;
- (PersonMO *)createPersonMO;
- (ChoreLogMO *)createChoreLogMO;

@end

