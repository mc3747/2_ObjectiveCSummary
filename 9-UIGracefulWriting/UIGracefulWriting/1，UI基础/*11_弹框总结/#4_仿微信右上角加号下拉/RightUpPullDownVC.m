//
//  RightUpPullDownVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "RightUpPullDownVC.h"
#import "PopoverView.h"

@interface RightUpPullDownVC ()
@property (nonatomic, strong) UIButton *popoverButton1;
@property (nonatomic, strong) UIButton *popoverButton2;
@property (nonatomic, strong) UIButton *popoverButton3;
@property (nonatomic, strong) UIButton *popoverButton4;
@property (nonatomic, strong) UIButton *popoverButton5;
@property (nonatomic, strong) UIButton *popoverButton6;
@property (nonatomic, strong) UILabel *noticeLabel;
@end

@implementation RightUpPullDownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.popoverButton1];
    [self.view addSubview:self.popoverButton2];
    [self.view addSubview:self.popoverButton3];
    [self.view addSubview:self.popoverButton4];
    [self.view addSubview:self.popoverButton5];
    [self.view addSubview:self.popoverButton6];
    [self.view addSubview:self.noticeLabel];
}
#pragma mark -  1,2,3button的点击事件
-(void)buttonAction1:(UIButton *)sender{
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.arrowStyle = PopoverViewArrowStyleTriangle;
    [popoverView showToView:sender withActions:[self QQActions]];
}
#pragma mark -  4button的点击事件
-(void)buttonAction2:(UIButton *)sender{
    GJWeakSelf;
    // 不带图片
    PopoverAction *action1 = [PopoverAction actionWithTitle:@"加好友" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action2 = [PopoverAction actionWithTitle:@"扫一扫" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action3 = [PopoverAction actionWithTitle:@"发起聊天" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action4 = [PopoverAction actionWithTitle:@"发起群聊" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action5 = [PopoverAction actionWithTitle:@"查找群聊" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action6 = [PopoverAction actionWithTitle:@"我的群聊" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    popoverView.hideAfterTouchOutside = NO; // 点击外部时不允许隐藏
    [popoverView showToView:sender withActions:@[action1, action2, action3, action4, action5, action6]];
}
#pragma mark -  5button的点击事件
-(void)buttonAction3:(UIButton *)sender{
    GJWeakSelf;
    PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_newmessage"] title:@"发起群聊" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action2 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_friend"] title:@"添加朋友" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action3 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_scan"] title:@"扫一扫" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    PopoverAction *action4 = [PopoverAction actionWithImage:[UIImage imageNamed:@"contacts_add_money"] title:@"收付款" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.style = PopoverViewStyleDark;
    // 在没有系统控件的情况下调用可以使用显示在指定的点坐标的方法弹出菜单控件.
    [popoverView showToPoint:CGPointMake(20, 64) withActions:@[action1, action2, action3, action4]];
}
#pragma mark -  6button的点击事件
-(void)buttonAction4:(UIButton *)sender{
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    [popoverView showToView:sender withActions:[self QQActions]];
}
- (UIButton *)popoverButton1
{
    if (!_popoverButton1) {
        _popoverButton1 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 40, 0, 80, 30)];
        [_popoverButton1 setBackgroundColor:[UIColor orangeRed] forState:UIControlStateNormal];
        [_popoverButton1 setTitle:@"popOver" forState:UIControlStateNormal];
        [_popoverButton1 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popoverButton1;
}
- (UIButton *)popoverButton2
{
    if (!_popoverButton2) {
        _popoverButton2 = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 64 - 50 - 49, 80, 30)];
        [_popoverButton2 setBackgroundColor:[UIColor orangeRed] forState:UIControlStateNormal];
        [_popoverButton2 setTitle:@"popOver" forState:UIControlStateNormal];
         [_popoverButton2 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popoverButton2;
}
- (UIButton *)popoverButton3
{
    if (!_popoverButton3) {
        _popoverButton3 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, SCREEN_HEIGHT - 64 - 50 - 49, 80, 30)];
        [_popoverButton3 setBackgroundColor:[UIColor orangeRed] forState:UIControlStateNormal];
        [_popoverButton3 setTitle:@"popOver" forState:UIControlStateNormal];
         [_popoverButton3 addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popoverButton3;
}
- (UIButton *)popoverButton4
{
    if (!_popoverButton4) {
        _popoverButton4 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 40, SCREEN_HEIGHT - 64 - 100 - 49, 80, 30)];
        [_popoverButton4 setBackgroundColor:[UIColor royalBlue] forState:UIControlStateNormal];
        [_popoverButton4 setTitle:@"popOver" forState:UIControlStateNormal];
        [_popoverButton4 addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popoverButton4;
}
- (UIButton *)popoverButton5
{
    if (!_popoverButton5) {
        _popoverButton5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [_popoverButton5 setBackgroundColor:[UIColor paleGreen] forState:UIControlStateNormal];
        [_popoverButton5 setTitle:@"popOver" forState:UIControlStateNormal];
        [_popoverButton5 addTarget:self action:@selector(buttonAction3:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popoverButton5;
}
- (UIButton *)popoverButton6
{
    if (!_popoverButton6) {
        _popoverButton6 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 80, 30)];
        [_popoverButton6 setBackgroundColor:[UIColor peruColor] forState:UIControlStateNormal];
        [_popoverButton6 setTitle:@"popOver" forState:UIControlStateNormal];
        [_popoverButton6 addTarget:self action:@selector(buttonAction4:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _popoverButton6;
}
- (UILabel *)noticeLabel
{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.5 - 100, 200, 200, 100)];
        _noticeLabel.backgroundColor = [UIColor paleVioletRed];
    }
    
    return _noticeLabel;
}
#pragma mark -  table里的内容
- (NSArray<PopoverAction *> *)QQActions {
    GJWeakSelf;
    // 发起多人聊天 action
    PopoverAction *multichatAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_multichat"] title:@"发起多人聊天" handler:^(PopoverAction *action) {
#pragma mark - 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
        weakSelf.noticeLabel.text = action.title;
    }];
    // 加好友 action
    PopoverAction *addFriAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"加好友" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    // 扫一扫 action
    PopoverAction *QRAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"扫一扫" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    // 面对面快传 action
    PopoverAction *facetofaceAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_facetoface"] title:@"面对面快传" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    // 付款 action
    PopoverAction *payMoneyAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"付款" handler:^(PopoverAction *action) {
        weakSelf.noticeLabel.text = action.title;
    }];
    
    return @[multichatAction, addFriAction, QRAction, facetofaceAction, payMoneyAction];
}
@end
