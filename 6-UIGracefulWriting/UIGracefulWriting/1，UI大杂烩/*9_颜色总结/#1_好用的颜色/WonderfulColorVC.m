//
//  WonderfulColorVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "WonderfulColorVC.h"

@interface WonderfulColorVC ()

@end

@implementation WonderfulColorVC
- (instancetype)init
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WonderfulColor" bundle:nil];
    WonderfulColorVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"WonderfulColorVC"];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}





@end
