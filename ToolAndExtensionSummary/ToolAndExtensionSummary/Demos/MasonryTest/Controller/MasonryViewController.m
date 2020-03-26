//
//  MasonryViewController.m
//  AutoLayoutViewDemo
//
//  Created by shavekevin on 16/4/15.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "MasonryViewController.h"
#import "SKLoopCreateViews.h"
#import "MMPlaceHolder.h"

static CGFloat const kDefaultLeftPadding = 5.0f;
static CGFloat const kDefaultBottomPadding = -5.0f;
static CGFloat const kNavigationBarHeight = 64.0f;
static CGFloat const kDefaultViewHeight = 200.0f;

@interface MasonryViewController ()

@property (strong, nonatomic) UIView *blueView;
@property (strong, nonatomic) UIView *yellowView;
@property (strong, nonatomic) UIView *blackView;
@property (strong, nonatomic) UIView *redView;
@property (nonatomic, strong) UIView *containerView;
/**
 *  循环创建view
 */
@property (nonatomic, strong) SKLoopCreateViews *loopViews;
@end

@implementation MasonryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createViews];
    self.view.backgroundColor = [UIColor whiteColor];
    self.loopViews = [[SKLoopCreateViews alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    self.loopViews.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.loopViews];
    [self.loopViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)createViews {
    
    self.containerView = [UIView new];
    [self.containerView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.containerView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kNavigationBarHeight);
        make.left.mas_equalTo(kDefaultLeftPadding);
        make.right.mas_equalTo(kDefaultBottomPadding);
        make.height.mas_equalTo(kDefaultViewHeight);
        
    }];
    
    self.yellowView = [UIView new];
    [self.yellowView setBackgroundColor:[UIColor colorWithRed:229/255.0 green:214 /255.0 blue:26/255.0 alpha:1.0f]];
    [self.containerView addSubview:self.yellowView];
    
    self.blueView = [UIView new];
    [self.blueView setBackgroundColor:[UIColor blueColor]];
    [self.containerView addSubview:self.blueView];
    
    self.blackView = [UIView new];
    [self.blackView setBackgroundColor:[UIColor blackColor]];
    [self.containerView addSubview:self.blackView];
    
    self.redView = [UIView new];
    [self.redView setBackgroundColor:[UIColor redColor]];
    [self.containerView addSubview:self.redView];
    
    [self.blackView showPlaceHolder];
    [self.yellowView showPlaceHolder];
    [self.blueView showPlaceHolder];
    [self.redView showPlaceHolder];
    
    [self.yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kDefaultLeftPadding);
        make.bottom.mas_equalTo(kDefaultBottomPadding);
        
    }];
    
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yellowView.mas_right).offset(kDefaultLeftPadding);
        make.top.mas_equalTo(kDefaultLeftPadding);
        make.right.mas_equalTo(kDefaultBottomPadding);
        make.width.mas_equalTo(self.yellowView.mas_width).multipliedBy(2);
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blackView);
        make.top.equalTo(self.blackView.mas_bottom).offset(kDefaultLeftPadding);
        make.bottom.mas_equalTo(kDefaultBottomPadding);
        make.height.mas_equalTo(self.blackView);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right).offset(kDefaultLeftPadding);
        make.bottom.equalTo(self.redView);
        make.right.equalTo(self.blackView);
        make.size.mas_equalTo(self.redView);
    }];

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
