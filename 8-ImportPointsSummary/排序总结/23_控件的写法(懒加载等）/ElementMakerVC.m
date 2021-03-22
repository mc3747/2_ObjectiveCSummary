//
//  ElementMakerVC.m
//  排序总结
//
//  Created by gjfax on 2019/9/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "ElementMakerVC.h"

@interface ElementMakerVC ()
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, weak) UIView *view3;
@end

@implementation ElementMakerVC
/*
 写控制器的3个基本
 1，初始化控件：initElements
 2，布局：addConstraint
 3，获取数据后更新：getData
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Wonderful_GrayColor6;
    [self view1];
    [self getView2];
    [self view3];
}

#pragma mark -  写法1：strong控制，懒加载，内部
- (UIView *)view1
{
// ⚠️：内部不能使用self.view2
    if (!_view1) {
        _view1 = [[UIView alloc] init];
        _view1.frame = CGRectMake(0, 100, 30, 30);
        _view1.backgroundColor = Wonderful_RedColor3;
        [self.view addSubview:_view1];
    }
    return _view1;
}
#pragma mark -  写法2：strong控制，懒加载，防止内部循环引用
- (UIView *)getView2{
    if (!self.view2) {
        self.view2 = [[UIView alloc] init];
        self.view2.frame = CGRectMake(40, 100, 30, 30);
        self.view2.backgroundColor = Wonderful_YelloeColor3;
        [self.view addSubview:self.view2];
    }
    
    return self.view2;
}

#pragma mark -  写法3：weak控制，懒加载
- (UIView *)view3
{
    if (!_view3) {
        UIView *view3 = [[UIView alloc] init];
        view3.frame = CGRectMake(80, 100, 30, 30);
        view3.backgroundColor = Wonderful_GreenColor3;
        [self.view addSubview:view3];
        _view3 = view3;
    }
    return _view3;
}


@end
