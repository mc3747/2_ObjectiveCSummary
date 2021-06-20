//
//  Test1ViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/21.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test2ViewController.h"
@interface Test1ViewController ()
@property (nonatomic, weak) UIView *maskView;
@end

@implementation Test1ViewController

- (void)loadView {
    [super loadView];
   
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    maskView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:maskView];
    [self.view bringSubviewToFront:maskView];
    [UIView animateWithDuration:0.5 animations:^{
        maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    [self performSelector:@selector(dismiss:) withObject:maskView afterDelay:2.f];
    _maskView = maskView;
}

- (void)dismiss:(UIView *)view {
    [UIView animateWithDuration:0.5 animations:^{
        view.alpha = 0.f;
        [view removeFromSuperview];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor redColor];
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    maskView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:maskView];
    
    UIView *maskView2 = [[UIView alloc] initWithFrame:CGRectMake(150, 100, 100, 100)];
    maskView2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:maskView2];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.view bringSubviewToFront:_maskView];
}

@end
