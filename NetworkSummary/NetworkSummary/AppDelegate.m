//
//  AppDelegate.m
//  NetworkSummary
//
//  Created by gjfax on 2018/8/23.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIKit+AFNetworking.h"
#import "AFNetworking.h"
#import <SparrowSDK.h>

#ifdef DEBUG
#import "YYFPSLabel.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *VC = [storyboard instantiateInitialViewController];
    //    ViewController *VC = [[ViewController alloc] init];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = naviVC;
    [self.window makeKeyAndVisible];
    
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] init];
    [self.window addSubview:fpsLabel];
    fpsLabel.center = CGPointMake(self.window.bounds.size.width - 50, 40);
    
    SPROptions *options = [SPROptions new];
//    options.hostURL = @"http://your.sparrow.host";
     options.hostURL = @"http://127.0.0.1";
    [SparrowSDK startWithOption:options];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
