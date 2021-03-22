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
#import "WXTabBarController.h"
#import "Common_ViewController.h"
#import "WXNavigationVC.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) WXTabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark -  配置nvigationController
- (UINavigationController *)navigationController {
    if (_navigationController == nil) {
        WXNavigationVC *navigationController = [[WXNavigationVC alloc] initWithRootViewController:self.tabBarController];
        _navigationController = navigationController;
    }
    return _navigationController;
}
#pragma mark -  配置tabBar
- (WXTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        WXTabBarController *tabBarController = [[WXTabBarController alloc] init];
        
        ViewController *mainframeViewController = ({
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController *mainframeViewController = [storyboard instantiateInitialViewController];
            
            UIImage *mainframeImage   = [UIImage imageNamed:@"tabbar_mainframe"];
            UIImage *mainframeHLImage = [UIImage imageNamed:@"tabbar_mainframeHL"];
            
            mainframeViewController.title = @"微信";
            mainframeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"微信" image:mainframeImage selectedImage:mainframeHLImage];
            mainframeViewController.tabBarItem.badgeValue = @"9";
            mainframeViewController.view.backgroundColor = [UIColor colorWithRed:48 / 255.0 green:67 / 255.0 blue:78 / 255.0 alpha:1];
            mainframeViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_add"]
                                                                                                         style:UIBarButtonItemStylePlain
                                                                                                        target:self
                                                                                                        action:@selector(didClickAddButton:)];
            
            mainframeViewController;
        });
        
        Common_ViewController *contactsViewController = ({
            Common_ViewController *contactsViewController = [[Common_ViewController alloc] init];
            contactsViewController.subtitleArray = @[@[@"cctableView",@"table基类-代理写",@"table基类-block写",@"tableViewController基类",@"多种cell组合",@"一般的小型封装",@"mvvm实现多种cell组合"]];
            contactsViewController.vcNameArray = @[@[@"",@"",@"",@"",@"",@"",@""]];
            UIImage *contactsImage   = [UIImage imageNamed:@"tabbar_contacts"];
            UIImage *contactsHLImage = [UIImage imageNamed:@"tabbar_contactsHL"];
            
            contactsViewController.title = @"通讯录";
            contactsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通讯录" image:contactsImage selectedImage:contactsHLImage];
            contactsViewController.view.backgroundColor = [UIColor colorWithRed:115 / 255.0 green:155 / 255.0 blue:6 / 255.0 alpha:1];
            
            contactsViewController;
        });
        
        Common_ViewController *discoverViewController = ({
            Common_ViewController *discoverViewController = [[Common_ViewController alloc] init];
            discoverViewController.subtitleArray = @[@[@"cctableView",@"table基类-代理写",@"table基类-block写",@"tableViewController基类",@"多种cell组合",@"一般的小型封装",@"mvvm实现多种cell组合"]];
            discoverViewController.vcNameArray = @[@[@"",@"",@"",@"",@"",@"",@""]];
            UIImage *discoverImage   = [UIImage imageNamed:@"tabbar_discover"];
            UIImage *discoverHLImage = [UIImage imageNamed:@"tabbar_discoverHL"];
            
            discoverViewController.title = @"发现";
            discoverViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:discoverImage selectedImage:discoverHLImage];
            discoverViewController.view.backgroundColor = [UIColor colorWithRed:32 / 255.0 green:85 / 255.0 blue:128 / 255.0 alpha:1];
            
            discoverViewController;
        });
        
        Common_ViewController *meViewController = ({
            Common_ViewController *meViewController = [[Common_ViewController alloc] init];
            meViewController.subtitleArray = @[@[@"cctableView",@"table基类-代理写",@"table基类-block写",@"tableViewController基类",@"多种cell组合",@"一般的小型封装",@"mvvm实现多种cell组合"]];
            meViewController.vcNameArray = @[@[@"",@"",@"",@"",@"",@"",@""]];
            UIImage *meImage   = [UIImage imageNamed:@"tabbar_me"];
            UIImage *meHLImage = [UIImage imageNamed:@"tabbar_meHL"];
            
            meViewController.title = @"我";
            meViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:meImage selectedImage:meHLImage];
            meViewController.view.backgroundColor = [UIColor colorWithRed:199 / 255.0 green:135 / 255.0 blue:56 / 255.0 alpha:1];
            
            meViewController;
        });
        
        tabBarController.title = @"微信";
        tabBarController.tabBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];

        tabBarController.viewControllers = @[
            [[UINavigationController alloc] initWithRootViewController:mainframeViewController],
            [[UINavigationController alloc] initWithRootViewController:contactsViewController],
            [[UINavigationController alloc] initWithRootViewController:discoverViewController],
            [[UINavigationController alloc] initWithRootViewController:meViewController],
        ];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (void)didClickAddButton:(id)sender {
    ViewController *viewController = [[ViewController alloc] init];
    
    viewController.title = @"添加";
    viewController.view.backgroundColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
    
    [self.navigationController pushViewController:viewController animated:YES];
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
