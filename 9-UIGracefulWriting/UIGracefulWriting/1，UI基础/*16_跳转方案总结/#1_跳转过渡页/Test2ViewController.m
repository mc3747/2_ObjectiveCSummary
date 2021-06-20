//
//  Test2ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/21.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()
@property (nonatomic, weak) UIView *maskView;
@property (nonatomic, weak) UILabel *countDownLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger restTime;
//  进度条
@property (nonatomic,strong) UIView  *progressLine;

@end

@implementation Test2ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
//  弹出动画框
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    maskView.backgroundColor = [UIColor whiteColor];
    [self.view bringSubviewToFront:maskView];
    self.navigationController.navigationBar.hidden = YES;
    [self addTopElements:maskView];
    [self addCenterElements:maskView];
    self.restTime = 2.f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(updateCountDownDisplay) userInfo:nil repeats:YES];
    [self.view addSubview:maskView];
    _maskView = maskView;
    
//  进度条
    [self creatProgressLine];
    [self startLoadingAnimation];
    
//   示例view
    UIView *maskView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    maskView1.backgroundColor = [UIColor blueColor];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pop)];
    [maskView1 addGestureRecognizer:gesture];
    [self.view addSubview:maskView1];
    
    UIView *maskView2 = [[UIView alloc] initWithFrame:CGRectMake(150, 100, 100, 100)];
    maskView2.backgroundColor = [UIColor orangeColor];
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [maskView2 addGestureRecognizer:gesture2];
    [self.view addSubview:maskView2];
    
}

#pragma mark - 创建进度条
- (void)creatProgressLine
{
    self.progressLine = [[UIView alloc] init];
    self.progressLine.backgroundColor = [UIColor orangeColor];
    self.progressLine.frame = CGRectMake(0, 64, 0, 3.0);
    [self.maskView addSubview:self.progressLine];
}

#pragma mark - 进度条开始动画
- (void)startLoadingAnimation
{
    GJWeakSelf;
    [UIView animateWithDuration:0.6 animations:^{
        weakSelf.progressLine.width = SCREEN_WIDTH * 0.55;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.4 animations:^{
                weakSelf.progressLine.width = SCREEN_WIDTH * 0.8;
            }];
        }
    }];
}

#pragma mark - 进度条结束动画
- (void)endLoadingAnimation
{
    GJWeakSelf;
    // 延时1s避免开始动画还没结束，结束动画走起
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.progressLine.width = SCREEN_WIDTH;
        } completion:^(BOOL finished) {
            if (finished) {
                weakSelf.progressLine.hidden = YES;
                weakSelf.progressLine.width = 0.0;
            }
        }];
//    });

}
#pragma mark -  添加顶部界面元素
- (void)addTopElements:(UIView *)maskView {
    
    //背景
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    topView.backgroundColor = Wonderful_GreenColor3;
    [maskView addSubview:topView];
    
    //返回箭头
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(6, STATUS_BAR_HEIGHT + 2, 40, 40)];
    [backButton setImage:[UIImage imageNamed:@"loan_close"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"loan_close_down"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:backButton];
    
    //中心title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, + STATUS_BAR_HEIGHT, SCREEN_WIDTH - 80, NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"广金服";
    [maskView addSubview:label];
}

#pragma mark -  添加中间元素
- (void)addCenterElements:(UIView *)maskView {
    
    //logo
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"gjf_logo"];
    CGFloat logoWidth = (SCREEN_WIDTH / 375) * 162.f;
    CGFloat logoHeight = (SCREEN_HEIGHT / 667) * 45.f;
    logoImageView.frame = CGRectMake(maskView.center.x - logoWidth * 0.5f, maskView.center.y - logoHeight, logoWidth, logoHeight);
    [maskView addSubview:logoImageView];
    
    //倒计时label
    UILabel *countDownLabel = [[UILabel alloc] init];
    countDownLabel.textAlignment = NSTextAlignmentCenter;
    countDownLabel.textColor = [UIColor blackColor];
    countDownLabel.font = [UIFont systemFontOfSize:16];
    countDownLabel.text = @"即将进入广金服 2s...";
    countDownLabel.frame = CGRectMake(0, maskView.center.y , SCREEN_WIDTH, 30);
    [maskView addSubview:countDownLabel];
    _countDownLabel = countDownLabel;
}

#pragma mark -  消失
- (void)dismiss:(UIView *)view {
    [self endLoadingAnimation];
    GJWeakSelf;

    [UIView animateWithDuration:0.5f animations:^{
        view.alpha = 0.f;
//        view.center = CGPointMake(0, SCREEN_HEIGHT * 2.f);
        
    } completion:^(BOOL finished) {
       
        [view removeFromSuperview];
        weakSelf.navigationController.navigationBar.hidden = NO;
    }];
}
#pragma mark -  更新倒计时显示
- (void)updateCountDownDisplay {
    self.restTime -= 1.f;
    _countDownLabel.text = [NSString stringWithFormat:@"即将进入广金服 %lis...",(long)self.restTime];
    if (self.restTime <= 0) {
        [self dismiss:_maskView];
        [self destroyTimer];
    }
}

#pragma mark -  销毁定时器
- (void)destroyTimer {
    [self.timer invalidate];
    self.timer = nil;
}


- (void)tap {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)pop
{
    
    CATransition* transition = [CATransition animation];
    
    transition.duration =0.4f;
    
    transition.type = kCATransitionReveal;
    
    transition.subtype = kCATransitionFromBottom;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.view bringSubviewToFront:_maskView];
}
@end
