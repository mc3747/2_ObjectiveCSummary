//
//  BZBaseViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/10.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "BZBaseViewController.h"

@interface BZBaseViewController ()

@end

@implementation BZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //ViewController的背景颜色，如果整个App页面背景颜色比较统一，建议在这里设置
    self.view.backgroundColor = Wonderful_GrayColor2;
    //设置导航栏
    [self setupNavigationItem];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    if ([kSystemVersion doubleValue] > 11.0) {
        //scrollerView在导航栏透明时不下压
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

-(void)setupNavigationItem{
    //导航栏背景
    UIImage * image =  [[UIImage imageNamed:@"img_navigationbar_bg"]
                        resizableImageWithCapInsets:UIEdgeInsetsMake(-1, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

-(void)setBackButton{
    //设置返回按钮
    UIBarButtonItem * backBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
}

-(void)setRightButton{
    //设置右按钮（图片）
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

-(void)setRightTextButton{
    //设置右按钮（文字）
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.rightTextButton];
    self.navigationItem.rightBarButtonItems = @[[self getNavigationSpacerWithSpacer:0],rightBarButton];
}

-(void)setNavigationTitleLabel{
    //设置标题
    self.navigationItem.titleView = self.navigationTitleLabel;
}

-(UIBarButtonItem *)getNavigationSpacerWithSpacer:(CGFloat)spacer{
    //设置导航栏左右按钮的偏移距离
    UIBarButtonItem *navgationButtonSpacer = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                              target:nil action:nil];
    navgationButtonSpacer.width = spacer;
    return navgationButtonSpacer;
}

#pragma mark - lazy 各控件的初始化方法
-(UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 50, 40);
        [_backButton setImage:[UIImage imageNamed:@"button_nav_back"] forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [_backButton addTarget:self action:@selector(navBackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 40, 40);
        [_rightButton addTarget:self action:@selector(navRightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UIButton *)rightTextButton{
    if (!_rightTextButton) {
        _rightTextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightTextButton.frame = CGRectMake(0, 0, 60, 40);
        _rightTextButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_rightTextButton addTarget:self action:@selector(navRightTextClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightTextButton;
}

-(UILabel *)navigationTitleLabel{
    if (!_navigationTitleLabel) {
        _navigationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 150, 30)];
        _navigationTitleLabel.font = [UIFont systemFontOfSize:17];
        _navigationTitleLabel.textColor = [UIColor whiteColor];
        _navigationTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _navigationTitleLabel;
}

#pragma mark - click 导航栏按钮点击方法，右按钮点击方法都需要子类来实现
-(void)navBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navRightClick{
    
}

-(void)navRightTextClick{
    
}

@end

