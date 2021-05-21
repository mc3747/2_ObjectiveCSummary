//
//  AppDelegate.m
//  MNFoundation
//
//  Created by Vincent on 2019/7/10.
//  Copyright © 2019 Vincent. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MNTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
   
    MNTabBarController *tabVC = [[MNTabBarController alloc] init];
    tabVC.controllers = @[@"FirstVC",@"SecondVC",@"ThirdVC",@"FourthVC"];
    
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];
    

    [MNDebuger startDebug];
    
    return YES;
}
-(NSArray<UIViewController * >*)returnBaseVC{
    NSArray *className = @[@"FirstVC",@"SecondVC",@"ThirdVC",@"FourthVC"];
    NSArray *titles = @[@"首页",@"分类",@"其它",@"我的"];
    NSArray *unselectImgs = @[@"icon1_tabbar_normal",@"icon2_tabbar_normal",@"icon3_tabbar_normal",@"icon4_tabbar_normal"];
    NSArray *selecImgs = @[@"icon1_tabbar_sel",@"icon2_tabbar_sel",@"icon3_tabbar_sel",@"icon4_tabbar_sel"];
    NSMutableArray *vcArrs = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i < 4; i++) {
        UIViewController *vc = [[NSClassFromString([className objectAtIndex:i]) alloc] init];
        vc.tabBarItem.title = titles[i];
        vc.tabBarItem.image = [UIImage imageNamed:unselectImgs[i]];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selecImgs[i]];
        [vcArrs addObject:vc];
    };
    return  vcArrs;
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
