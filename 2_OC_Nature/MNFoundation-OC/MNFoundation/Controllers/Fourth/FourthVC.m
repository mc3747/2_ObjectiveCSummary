//
//  SecondVC.m
//  HKProject
//
//  Created by rubick on 2016/11/25.
//  Copyright © 2016年 hjkl. All rights reserved.
//

#import "FourthVC.h"


@interface FourthVC ()

@end

@implementation FourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
}

- (NSString *)tabBarItemTitle{
    return @"第四";
}
- (UIImage *)tabBarItemImage{
    return  [UIImage imageNamed:@"icon4_tabbar_normal"];
}
- (UIImage *)tabBarItemSelectedImage{
    return  [UIImage imageNamed:@"icon4_tabbar_sel"];
}
@end
