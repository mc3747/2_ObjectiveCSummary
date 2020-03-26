//
//  CustomBaseVC.m
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2017/12/27.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "CustomBaseVC.h"

@interface CustomBaseVC ()

@end

@implementation CustomBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 状态栏20 + 导航栏44
    self.navTopHeight =  [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    // 左侧文字
        [self leftTitleConfig];
    // 右侧文字
        [self rightTitleConfig];
}

#pragma mark - 左侧文字
- (void)leftTitleConfig {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftTarget)];
    //     UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Navi_Back_Dark_10x18_"] style:UIBarButtonItemStylePlain target:self action:@selector(leftTarget)];
    [leftItem setTintColor:UIColorRed];
    self.navigationItem.backBarButtonItem = leftItem;
    
}

- (void)leftTarget {
    
}
#pragma mark - 右侧文字
- (void)rightTitleConfig {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightTarget)];
    [rightItem setTintColor:UIColorRed];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)rightTarget {
    [self.navigationController popToRootViewControllerAnimated:YES];
}




@end
