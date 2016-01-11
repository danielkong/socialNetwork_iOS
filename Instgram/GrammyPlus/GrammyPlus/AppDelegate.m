//
//  AppDelegate.m
//  GrammyPlus
//
//  Created by Daniel Kong on 1/10/16.
//  Copyright © 2016 Daniel Kong. All rights reserved.
//
//CLIENT ID	1ea9fad138604cfd8022f513ac380fe9
//CLIENT SECRET	416b8cc125b248e28dd2e4ca0ecc6956
//WEBSITE URL	https://www.linkedin.com/in/xianglongkong
//REDIRECT URI	https://www.linkedin.com/in/xianglongkong

#import "AppDelegate.h"
#import "NXOAuth2.h"   

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[NXOAuth2AccountStore sharedStore] setClientID:@"1ea9fad138604cfd8022f513ac380fe9"
                                             secret:@"416b8cc125b248e28dd2e4ca0ecc6956"
                                   authorizationURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/authorize"]
                                           tokenURL:[NSURL URLWithString:@"https://api.instagram.com/oauth/access_token"]
                                        redirectURL:[NSURL URLWithString:@"scheme://thing.com"]
                                     forAccountType:@"Instagram"];
    
    return YES;
}

// deprecated in iOS 9
//- (void)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url {
//
//}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options {
    return [[NXOAuth2AccountStore sharedStore] handleRedirectURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
