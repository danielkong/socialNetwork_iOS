//
//  ViewController.m
//  TwitterShare
//
//  Created by Daniel Kong on 12/31/15.
//  Copyright © 2015 Daniel Kong. All rights reserved.
//

// 1. setting up user interface with storyboard
// 2. connecting UI
// 3. styling via .layer
// 4. social framework and building alertController
// 5. closing window with UIAlertAction
// 6. checking single sign-on
// 7. general pattern for alertAction

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()

// add connection-1

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // stylize UI
    [self configuareTweetTextView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertMessage:(NSString *)myMessage {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"twitterShare" message:myMessage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];

}

// add connection-2

- (IBAction)showShareAction:(id)sender {
    // hidden keyboard
    if ([self.tweetTextView isFirstResponder]) {
        [self.tweetTextView resignFirstResponder];
    }
    
    UIAlertController *actionController = [UIAlertController alertControllerWithTitle:@"Title" message:@"Tweet your note" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertControllerStyleActionSheet = 0,
//    UIAlertControllerStyleAlert
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    ////
//        UIAlertController *actionController2 = [UIAlertController alertControllerWithTitle:@"Title2" message:@"Tweet your note2" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:actionController2 animated:YES completion:nil];
    ////
    
    UIAlertAction *tweetAction = [UIAlertAction actionWithTitle:@"Tweet" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        // dismiss first alertController, and show second alertController
//        UIAlertController *actionController2 = [UIAlertController alertControllerWithTitle:@"Title2" message:@"Tweet your note2" preferredStyle:UIAlertControllerStyleAlert];
//        [self presentViewController:actionController2 animated:YES completion:nil];

        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            // tweet out the tweet
            SLComposeViewController *twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            
            if ([self.tweetTextView.text length] < 140) {
                [twitterVC setInitialText:self.tweetTextView.text];
            } else {
                NSString *shortText = [self.tweetTextView.text substringToIndex:140];
                [twitterVC setInitialText:shortText];
            }
            [self presentViewController:twitterVC animated:YES completion:nil];
        } else {
            // raise some kind of objection
            [self showAlertMessage:@"You are not signed in to Twitter"];
        
        }
    }];
//  UIAlertAction:
//    UIAlertActionStyleDefault   // blue xi
//    UIAlertActionStyleCancel    // blue bold
//    UIAlertActionStyleDestructive // red xi
    
    [actionController addAction:cancelAction];
    [actionController addAction:tweetAction];

    [self presentViewController:actionController animated:YES completion:nil];


}

// styling UI via ".layer"
- (void)configuareTweetTextView {
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.9 alpha:1].CGColor; // yellow
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
    
}

// social.framework and building a UIAlerrtController

@end
