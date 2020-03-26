//
//  UserTestVC.m
//  MasonryFirDemo
//
//  Created by gjfax on 2018/5/23.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "UserTestVC.h"

@interface UserTestVC ()
@property (nonatomic, weak) UIButton *oneButton;
@property (nonatomic, weak) UIButton *twoButton;
@property (nonatomic, weak) UIView *oneView;
@property (nonatomic, weak) UIView *twoView;
@property (nonatomic, weak) UIView *threeView;

@end
/*
 使用masonry注意点：
 1，使用Masonry添加约束之前，需要在addSubview之后才能使用，否则会导致崩溃
 
 2，Masonry基础API
 mas_makeConstraints()    添加约束
 mas_remakeConstraints()  移除之前的约束，重新添加新的约束
 mas_updateConstraints()  更新约束，写哪条更新哪条，其他约束不变
 equalTo()       参数是对象类型，一般是视图对象或者mas_width这样的坐标系对象
 mas_equalTo()   和上面功能相同，参数可以传递基础数据类型对象，可以理解为比上面的API更强大
 width()         用来表示宽度，例如代表view的宽度
 mas_width()     用来获取宽度的值。和上面的区别在于，一个代表某个坐标系对象，一个用来获取坐标系对象的值
 
 更新约束和布局
 
 3，关于更新约束布局相关的API，主要用以下四个API：
 
 - (void)updateConstraintsIfNeeded  调用此方法，如果有标记为需要重新布局的约束，则立即进行重新布局，内部会调用updateConstraints方法
 - (void)updateConstraints          重写此方法，内部实现自定义布局过程
 - (BOOL)needsUpdateConstraints     当前是否需要重新布局，内部会判断当前有没有被标记的约束
 - (void)setNeedsUpdateConstraints  标记需要进行重新布局
 
 关于UIView重新布局相关的API，主要用以下三个API：
 - (void)setNeedsLayout  标记为需要重新布局
 - (void)layoutIfNeeded  查看当前视图是否被标记需要重新布局，有则在内部调用layoutSubviews方法进行重新布局
 - (void)layoutSubviews  重写当前方法，在内部完成重新布局操作

 4，使用insets简化内边距
  make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
 
 5，使用结构体约束
 make.center.equalTo(self.view);
  这里通过mas_equalTo给size设置了基础数据类型的参数，参数为CGSize的结构体
 make.size.mas_equalTo(CGSizeMake(300, 300));
 
 6，大于等于或者小于等于
  设置宽度小于等于200
 make.width.lessThanOrEqualTo(@200);
  设置高度大于等于10
 make.height.greaterThanOrEqualTo(@(10));
 
 7，约束的优先级
 Masonry为我们提供了三个默认的方法，priorityLow()、priorityMedium()、priorityHigh()，这三个方法内部对应着不同的默认优先级。
 除了这三个方法，我们也可以自己设置优先级的值，可以通过priority()方法来设置。
 make.width.equalTo(self.view).priorityLow();
 make.width.mas_equalTo(20).priorityHigh();
 make.height.equalTo(self.view).priority(200);
 make.height.mas_equalTo(100).priority(1000);
 
 */


@implementation UserTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(88);
        make.width.equalTo(self.view).multipliedBy(0.5).offset(-30);
        make.height.equalTo(@50);
    }];
    
    [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.top.height.width.equalTo(self.oneButton);
    }];
    
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneButton.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    [self.twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneView.mas_bottom);
        make.left.right.equalTo(self.oneView);
        make.height.equalTo(@50);
    }];
    
    [self.threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoView.mas_bottom);
        make.left.right.equalTo(self.oneView);
        make.height.equalTo(@50);
    }];
}


- (void)addTarget {
    [self.twoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.twoView.bounds.size.height + 10));
    }];
    [self.view updateConstraintsIfNeeded];
}

- (void)reduceTarget {
    [self.twoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.twoView.bounds.size.height - 10));
    }];
    [self.view updateConstraintsIfNeeded];
}

- (UIButton *)oneButton
{
    if (!_oneButton) {
        UIButton *oneButton = [[UIButton alloc] init];
        [oneButton setBackgroundColor:[UIColor redColor]];
        [oneButton setTitle:@"增加" forState:UIControlStateNormal];
        [oneButton addTarget:self action:@selector(addTarget) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:oneButton];
        _oneButton = oneButton;
    }
    return _oneButton;
}

- (UIButton *)twoButton
{
    if (!_twoButton) {
        UIButton *twoButton = [[UIButton alloc] init];
        [twoButton setBackgroundColor:[UIColor greenColor]];
        [twoButton setTitle:@"减少" forState:UIControlStateNormal];
        [twoButton addTarget:self action:@selector(reduceTarget) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:twoButton];
        _twoButton = twoButton;
    }
    return _twoButton;
}

- (UIView *)oneView
{
    if (!_oneView) {
       UIView *oneView = [[UIView alloc] init];
        oneView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:oneView];
        _oneView = oneView;
    }
    return _oneView;
}
- (UIView *)twoView
{
    if (!_twoView) {
        UIView *twoView = [[UIView alloc] init];
        twoView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:twoView];
        _twoView = twoView;
    }
    return _twoView;
}
- (UIView *)threeView
{
    if (!_threeView) {
        UIView *threeView = [[UIView alloc] init];
        threeView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:threeView];
        _threeView = threeView;
    }
    return _threeView;
}
@end
