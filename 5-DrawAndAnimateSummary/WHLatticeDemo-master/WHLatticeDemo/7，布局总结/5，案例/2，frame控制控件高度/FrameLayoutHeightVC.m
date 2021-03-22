//
//  FrameLayoutHeightVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2019/12/13.
//  Copyright © 2019 remember17. All rights reserved.
//

#import "FrameLayoutHeightVC.h"
#import "TriangleTextFieldView.h"

@interface FrameLayoutHeightVC ()
@property (nonatomic, strong) TriangleTextFieldView *textFieldView;
@property (nonatomic, strong) UIView *testView;
@end

@implementation FrameLayoutHeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 150, 30)];
     button1.backgroundColor = [UIColor greenColor];
     [button1 setTitle:@"显示错误❎" forState:UIControlStateNormal];
     [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] ;
     button1.titleLabel.adjustsFontSizeToFitWidth = YES;
     [button1 addTarget:self action:@selector(increaseAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:button1];
     
     UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(170, 100, 150, 30)];
     [button2 setTitle:@"隐藏错误✅" forState:UIControlStateNormal];
     [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] ;
      button2.titleLabel.adjustsFontSizeToFitWidth = YES;
     button2.backgroundColor = [UIColor redColor];
     [button2 addTarget:self action:@selector(reduceAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:button2];
    
    TriangleTextFieldView *textFieldView = [[TriangleTextFieldView  alloc] initWithFrame:CGRectMake(0, 160, 200, 50)];
    [self.view addSubview:textFieldView];
    _textFieldView = textFieldView;
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, textFieldView.frame.origin.y + textFieldView.frame.size.height, 100, 30)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    _testView = testView;
}

- (void)increaseAction:(UIButton *)button{
    [_textFieldView showWarning:@"测试错误"];
//    方法1：直接写在触发方法里
//    [self changeLimit];
    
}

- (void)reduceAction:(UIButton *)button{
    [_textFieldView hideWarning];
//     [self changeLimit];
}

//方法2：改变子view的frame后，调用setNeedsLayout，可以自动在viewDidLayoutSubviews方法里重写坐标关系
//方法3：改变子view的frame后，强制调用父控制器的viewDidLayoutSubviews方法，重写坐标关系
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self changeLimit];
}

- (void)changeLimit{
        _testView.frame = CGRectMake(0,_textFieldView.frame.origin.y + _textFieldView.frame.size.height, CGRectGetWidth(_testView.frame), CGRectGetHeight(_testView.frame));
}
@end
