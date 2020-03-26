//
//  CustomNaviVC.m
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2017/12/27.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "CustomNaviVC.h"

@interface CustomNaviVC ()

@end

@implementation CustomNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
// 在导航控制器中进行通用设置：navigationController中设置NavigationBar
// 在控制器中进行通用设置：CustomBaseController中设置NavigationItem
    // 背景
    [self backgroundConfig];
    // 底部分割线
    [self bottomLineConfig];
    // 标题文字
    [self titleConfig];
    // 返回箭头
    [self leftArrowConfig];
    // 手势返回
    [self gestureBackConfig];
    // 顶部进度条
    
}

#pragma mark - 背景
- (void)backgroundConfig {
    [self.navigationBar setBarTintColor:UIColorBlue];
}

#pragma mark - 底部分割线
- (void)bottomLineConfig {
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - 标题文字
- (void)titleConfig {
    
    NSMutableDictionary *textDic = [NSMutableDictionary dictionary];
    textDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textDic[NSFontAttributeName] = Common18SystemFont;
    
    //  取消阴影就是将offset设置为0
    textDic[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [self.navigationBar setTitleTextAttributes:textDic];
    
}
#pragma mark - 返回箭头及文字主题色
- (void)leftArrowConfig {
    [self.navigationBar setTintColor:UIColorWhite];
}


#pragma mark - 手势返回
- (void)gestureBackConfig {
    
}

@end
