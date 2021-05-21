//
//  SecondVC.m
//  HKProject
//
//  Created by rubick on 2016/11/25.
//  Copyright © 2016年 hjkl. All rights reserved.
//

#import "SecondVC.h"


@interface SecondVC ()

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
}

- (NSString *)tabBarItemTitle{
    return @"第二";
}
- (UIImage *)tabBarItemImage{
    return  [UIImage imageNamed:@"icon2_tabbar_normal"];
}
- (UIImage *)tabBarItemSelectedImage{
    return  [UIImage imageNamed:@"icon2_tabbar_sel"];
}
@end
