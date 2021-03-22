//
//  CAGradientLayerVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2018/11/6.
//  Copyright © 2018 remember17. All rights reserved.
//

#import "CAGradientLayerVC.h"

@interface CAGradientLayerVC ()

@end

@implementation CAGradientLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    containerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:containerView];
    
    // 渐变色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = containerView.bounds;
    [containerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    // 多颜色渐变
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(100, 400, 200, 200)];
    [self.view addSubview:containView];
    
    CAGradientLayer *conGradient = [CAGradientLayer layer];
    conGradient.frame = containView.bounds;
    [containView.layer addSublayer:conGradient];
    
    conGradient.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor purpleColor].CGColor];
    conGradient.locations = @[@(0.0), @(0.25), @(0.4), @(0.7)];
    conGradient.startPoint = CGPointMake(0, 0);
    conGradient.endPoint = CGPointMake(1, 1);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
