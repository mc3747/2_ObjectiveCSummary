//
//  SecondVC.m
//  HKProject
//
//  Created by rubick on 2016/11/25.
//  Copyright © 2016年 hjkl. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"基础";
    self.view.backgroundColor = [UIColor randomColor];
    self.navigationItem.title = @"基础";
}

- (NSString *)tabBarItemTitle{
    return @"第一";
}
- (UIImage *)tabBarItemImage{
    return  [UIImage imageNamed:@"icon1_tabbar_normal"];
}
- (UIImage *)tabBarItemSelectedImage{
    return  [UIImage imageNamed:@"icon1_tabbar_sel"];
}
@end
