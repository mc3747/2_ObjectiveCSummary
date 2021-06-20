//
//  ShadeEffectVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/8/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ShadeEffectVC.h"
#import "UIView+Gradient.h"

@interface ShadeEffectVC ()

@end

@implementation ShadeEffectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 200, 30)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 200, 30)];
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, 200, 30)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 200, 30)];
    
    [self.view addSubview:label];
    [self.view addSubview:btn];
    [self.view addSubview:tempView];
    [self.view addSubview:imageView];
    
    label.backgroundColor = [UIColor clearColor];
    btn.backgroundColor = [UIColor blueColor];
    tempView.backgroundColor = [UIColor blueColor];
    imageView.backgroundColor = [UIColor blueColor];
    
//    渐变效果
    [label setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    [btn setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    [tempView setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    [imageView setGradientBackgroundWithColors:@[[UIColor redColor],[UIColor orangeColor]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    
    label.text = @"Text";
    label.textAlignment = NSTextAlignmentCenter;
    
    [btn setTitle:@"Button" forState:UIControlStateNormal];
}




@end
