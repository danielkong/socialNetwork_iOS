//
//  ViewController.m
//  GrammyPlus
//
//  Created by Daniel Kong on 1/10/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//

//CLIENT ID	1ea9fad138604cfd8022f513ac380fe9
//CLIENT SECRET	416b8cc125b248e28dd2e4ca0ecc6956
//WEBSITE URL	https://www.linkedin.com/in/xianglongkong
//REDIRECT URI	https://www.linkedin.com/in/xianglongkong

#import "ViewController.h"
#import "NXOAuth2.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.logoutButton.enabled = false;
    self.refreshButton.enabled = false;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    // typo here cause crash
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:@"Instagram"];
    self.logoutButton.enabled = true;
    self.refreshButton.enabled = true;
    self.loginButton.enabled = false;
}

- (IBAction)logoutButtonPressed:(id)sender {
    NSArray *arr = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"Instagram"];
    for (id account in arr) {
        [[NXOAuth2AccountStore sharedStore] removeAccount:account];
    }

    self.logoutButton.enabled = false;
    self.refreshButton.enabled = false;
    self.loginButton.enabled = true;
}

- (IBAction)RefreshButtonPressed:(id)sender {
    NSArray *arr = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"Instagram"];
    if ([arr count] == 0) {
        NSLog(@"test");
        return;
    }
    
    NXOAuth2Account *account = arr[0];
    NSString *token = account.accessToken.accessToken;
    NSString *urlStr = [@"https://api.instagram.com/v1/users/self/media/recent/?access_token=" stringByAppendingString:token];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error){
        // network error
        if (error){
            NSLog(@"opps1");
            return;
        }
        
        // http error
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
        if (httpRes.statusCode <200 || httpRes.statusCode >=300) {
            NSLog(@"opps2 ---");
            return;
        }
        
        //json parse error
        NSError *parseErr;
        id pkg = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseErr];
        if (!pkg) {
            NSLog(@"opps3");
            return;
        }
        
        NSString *imgURLStr = pkg[@"data"][0][@"images"][@"standard_resolution"][@"url"];
        NSURL *imgURL = [NSURL URLWithString:imgURLStr];
        [[session dataTaskWithURL:imgURL completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
            // network error
            if (error){
                NSLog(@"opps12");
                return;
            }
            
            // http error
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
            if (httpRes.statusCode < 200 || httpRes.statusCode >=300) {
                NSLog(@"opps22");
                return;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = [UIImage imageWithData:data];
            });
        }] resume];
    }] resume];
    
}

@end
