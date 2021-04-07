//
//  WXNavigationVC.m
//  排序总结
//
//  Created by gjfax on 2020/3/13.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "WXNavigationVC.h"
#import "WXNavigationBar.h"
///MARK:  iPhone X 刘海屏系列宏定义判断（适用目前所有的iPhone刘海屏）
#define INTERFACE_IS_IPHONEX  (@available(iOS 11.0, *) && ([UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom > 0)?YES:NO)
@interface WXNavigationVC ()

@end

@implementation WXNavigationVC
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}
+ (void)load {
    [super load];
    
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navigationBar setTitleTextAttributes:dict];

//    [navigationBar setBackgroundImage:[UIImage image] forBarMetrics:UIBarMetricsDefault];
  
    navigationBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
    
}





@end
