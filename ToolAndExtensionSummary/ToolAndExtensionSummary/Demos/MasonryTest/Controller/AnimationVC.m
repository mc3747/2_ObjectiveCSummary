//
//  ViewController.m
//  MasonryAnimation
//
//  Created by shavekevin on 16/1/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "AnimationVC.h"
@interface AnimationVC (){
    /**
     *  左边的按钮
     */
    UIButton *leftButton;
    /**
     *  右边的按钮
     */
    UIButton *rightButton;
    /**
     *  按钮之间的占位view
     */
    UIView *placeHolderView;

}
/**
 *  移动的view
 */
@property (nonatomic,strong) UIView *moveView;


@end

@implementation AnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpView];
    [self addConstraints];
 

}
- (void)addConstraints {
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(2);
        make.height.mas_equalTo(50);
        make.right.equalTo(placeHolderView.mas_left).offset(0);
    }];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(leftButton.mas_top);
        make.right.mas_equalTo(-2);
        make.height.mas_equalTo(50);
        make.left.equalTo(placeHolderView.mas_right).offset(0);
    }];
    [placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(2);
        make.top.mas_equalTo(rightButton.mas_top);
        make.height.mas_equalTo(52);
    }];
    [_moveView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(2);
        make.top.equalTo(leftButton.mas_bottom).offset(0);
        make.height.mas_equalTo(2);
        make.right.equalTo(placeHolderView.mas_left).offset(0);
    }];
}

- (void)setUpView {
    
    placeHolderView = [UIView new];
    placeHolderView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:placeHolderView];
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"leftbutton" forState:UIControlStateNormal];
    leftButton.layer.cornerRadius = 2.0f;
    leftButton.clipsToBounds = YES;
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor redColor]];
    [leftButton addTarget:self action:@selector(buttonPressAction:)
         forControlEvents:UIControlEventTouchUpInside];
    leftButton.tag = 1000;
    [self.view addSubview:leftButton];
    
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"rightButton" forState:UIControlStateNormal];
    rightButton.layer.cornerRadius = 2.0f;
    rightButton.clipsToBounds = YES;
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor orangeColor]];
    [rightButton addTarget:self action:@selector(buttonPressAction:)
          forControlEvents:UIControlEventTouchUpInside];
    rightButton.tag = 1001;
    [self.view addSubview:rightButton];
    
    _moveView = [[UIView alloc]init];
    _moveView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:[self moveView]];
    
}

- (void)buttonPressAction:(UIButton *)sender {
    
    if (sender.tag == 1000) {

        [_moveView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(2);
            make.top.equalTo(leftButton.mas_bottom).offset(0);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(leftButton.mas_width);
        }];
        [UIView animateWithDuration:0.5f animations:^{
            
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
        }];
    } else if (sender.tag == 1001) {

        [_moveView mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-2);
            make.top.equalTo(leftButton.mas_bottom).offset(0);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(leftButton.mas_width);
        }];
            [UIView animateWithDuration:0.5f animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
