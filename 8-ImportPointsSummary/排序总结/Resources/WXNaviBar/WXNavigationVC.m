//
//  WXNavigationVC.m
//  排序总结
//
//  Created by gjfax on 2020/3/13.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "WXNavigationVC.h"

@interface WXNavigationVC ()

@end

@implementation WXNavigationVC

+ (void)load {
    [super load];
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [navigationBar setTitleTextAttributes:dict];

//    [navigationBar setBackgroundImage:[UIImage image] forBarMetrics:UIBarMetricsDefault];
    navigationBar.tintColor = [UIColor colorWithRed:26 / 255.0 green:178 / 255.0 blue:10 / 255.0 alpha:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
