//
//  UnderlineButtonVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/9.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "UnderlineButtonVC.h"
#import "CommonUnderlineButton.h"

@interface UnderlineButtonVC ()

@end

@implementation UnderlineButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CommonUnderlineButton *btn = [[CommonUnderlineButton alloc]
                                  initWithButtonFrame: CGRectMake(10, 100, 200, 50)
                                  textNormalColor:[UIColor yellowColor]
                                  textHighlightColor:[UIColor blueColor]
                                  lineNormalColor:[UIColor yellowColor]
                                  lineHighlightColor:[UIColor redColor]
                                  underDistance:5.f clickBlock:^(CommonUnderlineButton *button) {
                                      NSLog(@"点击了");
                                  }];
    
    [btn setTitle:@"带下划线的button" forState:UIControlStateNormal];
    
    [self pushVCWithView:btn];
}

#pragma mark -  push出通用控制器
- (void)pushVCWithView:(UIView *)view {
    CommonViewController *vc = [[CommonViewController alloc] init];
    [vc.view addSubview:view];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
