//
//  ViewController.m
//  SimpleCoreData
//
//  Created by Daniel Kong on 1/17/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ChoreMO.h"

@interface ViewController ()
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UILabel *persistedData;
@property (weak, nonatomic) IBOutlet UILabel *countOfCoreData;
@property (weak, nonatomic) IBOutlet UITextField *choreName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setting up core data
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self updateLogList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapChore:(id)sender {
    ChoreMO *c = [self.appDelegate createChoreMO];
    c.chore_name = self.choreName.text;
    // save to disk
    [self.appDelegate saveContext];
    [self updateLogList];
    

}
- (IBAction)tapDelete:(id)sender {
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:req error:&error];
    if (!results) {
        NSLog(@"Error fetching person object");
        abort();
    }

    for (ChoreMO *c in results) {
        [moc deleteObject:c];
    }
    
    [self.appDelegate saveContext];
    [self updateLogList];
}

- (void)updateLogList {
    // get all chore first
    NSManagedObjectContext *moc = self.appDelegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Chore"];
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching person object");
        abort();
    }
    NSMutableString * buffer = [NSMutableString stringWithString:@""];
    for (ChoreMO *c in results) {
        [buffer appendFormat:@"\n%@", c.chore_name, nil];
    }
    
    self.persistedData.text = buffer;
    self.countOfCoreData.text = [NSString stringWithFormat:@"Core Data Count: %ld",[results count]];
}

@end
