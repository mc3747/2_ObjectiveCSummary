//
//  ViewController.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/4/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "MasonryAPIVC.h"
#import "MMPlaceHolder.h"

@interface MasonryAPIVC ()
@property (nonatomic, strong)MASConstraint *height;
@end

@implementation MasonryAPIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
   self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view showPlaceHolder];
    [self createBottomButton];
    [self createViews];
    
}

- (void)createViews {
    
    /**
     *  基本例子
     *
     *  @param make 视图左右宽高定 已经固定
     *
     *  @return blueview
     */
    UIView *blueView = [UIView new];
    [blueView showPlaceHolder];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.top.equalTo(self.view.mas_top).offset(100);
        // 如果是相对于父视图的话 我们可以这样写
        //  make.top.mas_equalTo(10);
        // left  和top 的值 如果 相对的是一个视图的left 和top  并且偏移量是一样的话 我们可以这样写
        //  make.left.top.mas_equalTo(10);
        make.width.mas_equalTo(@50);
        self.height = make.height.mas_equalTo(50);
        // 上面两行等价于
        //  make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    /**
     *  centerX举例
     */
    
    UIView *orangeView = [UIView new];
    [orangeView showPlaceHolder];
    orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(blueView.mas_top);
        make.size.equalTo(blueView);
        
    }];
    
    /**
     *  centerY举例
     */
    UIView *yellowView = [UIView new];
    [yellowView showPlaceHolder];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(-50);;
        make.left.equalTo(orangeView.mas_right).offset(5);
        make.right.mas_equalTo(-20);
    }];
    
    UIButton *redButton= [UIButton buttonWithType:UIButtonTypeCustom];
    redButton.backgroundColor = [UIColor redColor];
    [redButton showPlaceHolder];
    redButton.tag = 1005;
    [redButton addTarget:self action:@selector(buttonPressAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redButton];
    [redButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //         make.centerX.mas_equalTo(0);
        //         make.centerY.mas_equalTo(0);
        // 这两句等价于
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    /**
     *  相对位置 通过centerY来举例
     */
    UIView *brownView = [UIView new];
    [brownView showPlaceHolder];
    [brownView setBackgroundColor:[UIColor brownColor]];
    [self.view addSubview:brownView];
    [brownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blueView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(blueView.mas_right).offset(10);
    }];
    /**
     *topMargin rightMargin 举例
     */
    UIButton *greenButton = [UIButton new];
    [greenButton setBackgroundColor: [UIColor greenColor]];
    [greenButton showPlaceHolder];
    [self.view addSubview:greenButton];
    greenButton.tag = 1006;
    [greenButton addTarget:self action:@selector(buttonPressAction:) forControlEvents:UIControlEventTouchUpInside];
    [greenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //Magain 的
        make.rightMargin.mas_equalTo(-8);
        make.topMargin.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
}

/**
 *  循环创建底部button
 */

- (void)createBottomButton {
    
    UIButton *tempButton;
    for (NSInteger i = 0; i < 5; i ++) {
        UIButton *contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        contentButton.backgroundColor = [UIColor purpleColor];
        contentButton.tag = 1000 + i;
        [contentButton setTitle:[NSString stringWithFormat:@"第%ld个",(long)i+1] forState:UIControlStateNormal];
        [contentButton addTarget:self action:@selector(buttonPressAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:contentButton];
        [contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 30));
            if (tempButton) {
                make.left.equalTo(tempButton.mas_right).offset(10);
                make.bottom.equalTo(tempButton.mas_bottom).offset(-10);
            } else {
                make.left.mas_equalTo(10);
                make.bottom.mas_equalTo(-10);
            }
        }];
        tempButton = contentButton;
    }
}
/**
 *  按钮响应方法
 *
 *  @param sender 按钮响应方法
 */
- (void)buttonPressAction:(UIButton *)sender {
    //  do some actions
    switch (sender.tag) {
        
        case 1003:
        {
            [self.height deactivate];
            [UIView animateWithDuration:2.0f animations:^{
                [self.view layoutIfNeeded];
                
            }];
        }
            break;
        case 1004:
        {
            [self.height activate];
            [UIView animateWithDuration:2.0f animations:^{
                [self.view layoutIfNeeded];
                
            }];
        }
            break;
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
