//
//  MoneyAnimationVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/8/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MoneyAnimationVC.h"
#import "UILabel+MoneyAnimation.h"

@interface MoneyAnimationVC ()

@end

@implementation MoneyAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 200, 30)];
    label.backgroundColor = [UIColor cyanColor];
    NSString *str = @"188969";
    double a = [str doubleValue]/100;
    NSString * num1 = [NSString stringWithFormat:@"%.2lf",a];
    [label dw_setNumber:@([num1 doubleValue])];
    [self.view addSubview:label];
}


@end
