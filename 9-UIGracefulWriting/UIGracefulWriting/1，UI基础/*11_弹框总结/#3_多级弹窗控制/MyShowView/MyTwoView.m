//
//  MyTwoView.m
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "MyTwoView.h"

@interface MyTwoView ()

@property (nonatomic,strong) UILabel *titleLb;

@end

@implementation MyTwoView


- (instancetype)init{
    CGRect frame = CGRectMake(0, 0, 300, 300);
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self configSubView];
    }
    return self;
}


- (void)configSubView{
    
    self.titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 40)];
    self.titleLb.backgroundColor = [UIColor whiteColor];
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLb];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn1.frame = CGRectMake(110, 220, 80, 30);
    [btn1 setTitle:@"2_view" forState:(UIControlStateNormal)];
    [self addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)btnClickAction:(UIButton *)sender{
    
    if (self.actionBlock) {
        self.actionBlock(sender);
    }
    
}

- (void)dealloc{
    NSLog(@"%@ dealloc.", NSStringFromClass([self class]));
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
}

@end
