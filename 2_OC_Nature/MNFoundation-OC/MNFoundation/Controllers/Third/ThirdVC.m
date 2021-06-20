//
//  SecondVC.m
//  HKProject
//
//  Created by rubick on 2016/11/25.
//  Copyright © 2016年 hjkl. All rights reserved.
//

#import "ThirdVC.h"


@interface ThirdVC ()

@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
}

- (NSString *)tabBarItemTitle{
    return @"第三";
}
- (UIImage *)tabBarItemImage{
    return  [UIImage imageNamed:@"icon3_tabbar_normal"];
}
- (UIImage *)tabBarItemSelectedImage{
    return  [UIImage imageNamed:@"icon3_tabbar_sel"];
}
@end
