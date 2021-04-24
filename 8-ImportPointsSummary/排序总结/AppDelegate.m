//
//  AppDelegate.m
//  排序总结
//
//  Created by gjfax on 2018/5/9.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HAMLogOutputWindow.h"

#import "Common_ViewController.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) MainTabBarController *mainTabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    // 隐藏顶部状态栏设为NO
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 设置顶部状态栏字体为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置主window视图
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor clearColor];
    
    _mainTabBarController = [[MainTabBarController alloc] init];
    //_mainTabBarController.view.userInteractionEnabled = NO;// 欢迎动画加载期间不允许永不与视图交互，加载完毕后设置为YES即可
    
    // 设置root视图控制器
    _window.rootViewController = _mainTabBarController;
    [_window makeKeyAndVisible];

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
