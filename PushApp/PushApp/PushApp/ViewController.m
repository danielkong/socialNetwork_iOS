//
//  ViewController.m
//  PushApp
//
//  Created by Daniel Kong on 1/11/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (void)requestPermissionToNotif;
- (void)createNotification:(int)secondsInTheFuture;

@end

@implementation ViewController

- (IBAction)pressSchedule:(id)sender {
    [self requestPermissionToNotif];
    [self createNotification:15];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestPermissionToNotif {
    // four different kinds of notif.
    // define two actions
    UIMutableUserNotificationAction *floatAction = [[UIMutableUserNotificationAction alloc] init];
    floatAction.identifier = @"FLOAT_ACTION";
    floatAction.title = @"float";
    floatAction.activationMode = UIUserNotificationActivationModeBackground;
    floatAction.destructive = YES; // indication render action 'red'
    floatAction.authenticationRequired = NO; // user password required
    
    
    UIMutableUserNotificationAction *stringAction = [[UIMutableUserNotificationAction alloc] init];
    stringAction.identifier = @"STRING_ACTION";
    stringAction.title = @"string";
    stringAction.activationMode = UIUserNotificationActivationModeForeground;
    stringAction.destructive = NO; // indication render action 'red'
    stringAction.authenticationRequired = NO; // user password required
    
    // define categories
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"MAIN_CATEGORY";
    [category setActions:@[floatAction, stringAction] forContext:UIUserNotificationActionContextDefault];
    
    NSSet *categories = [NSSet setWithObjects:category,nil];
    
    // local notif
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
    // register category
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

- (void)createNotification:(int)secondsInTheFuture {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:secondsInTheFuture];
    
    // global, then time zone.
    localNotif.timeZone = nil;
    
    localNotif.alertTitle = @"Alert Title";
    localNotif.alertBody = @"body";
    localNotif.alertAction = @"Done";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    
    //set badge number
    localNotif.applicationIconBadgeNumber = 4;
    // add category
    localNotif.category = @"MAIN_CATEGORY";

    [[UIApplication sharedApplication] scheduledLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

@end
