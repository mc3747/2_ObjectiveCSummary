//
//  ReceiveValueVC.m
//  排序总结
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ReceiveValueVC.h"
#import "GCD_Singleton.h"

@interface ReceiveValueVC ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ReceiveValueVC

- (instancetype)init {
    if (self = [super init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tzAction:) name:@"A2B" object:nil];

    };
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 150, 50)];
    _textField.placeholder = @"请输入传递的值";
//    _textField.text = _string;
    _textField.text = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"text"];
    _textField.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:_textField];
    
    SEL sel1 = @selector(test1);
    UIButton *btn1 = [self getButton:@"1,反向代理传值" :sel1];
    btn1.frame = CGRectMake(20, 200, 150, 50);
    
    SEL sel2 = @selector(test2);
    UIButton *btn2 = [self getButton:@"2,反向block传值" :sel2];
    btn2.frame = CGRectMake(200, 200, 150, 50);
    
    SEL sel3 = @selector(test3);
    UIButton *btn3 = [self getButton:@"3,反向通知传值" :sel3];
    btn3.frame = CGRectMake(20, 270, 150, 50);
 
    SEL sel4 = @selector(test4);
    UIButton *btn4 = [self getButton:@"4,反向单例传值" :sel4];
    btn4.frame = CGRectMake(200, 270, 150, 50);
//    self.textField.text = [GCD_Singleton sharedInstance].value;
    
    SEL sel5 = @selector(test5);
    UIButton *btn5 = [self getButton:@"5,反向KVO传值" :sel5];
    btn5.frame = CGRectMake(20, 340, 150, 50);
}


#pragma mark -  1，反向代理传值
- (void)test1 {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(passValue:)]) {
        [self.delegate passValue:self.textField.text];
    };
    
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  2，反向代理传值
- (void)test2 {

    if (self.block) {
        self.block(self.textField.text);
    };
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  3，反向通知传值
- (void)test3 {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"B2A" object:nil userInfo:@{@"key":self.textField.text}];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  4，反向单例传值
- (void)test4 {
     [GCD_Singleton sharedInstance].value = self.textField.text;
     [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  5，反向KVO传值
- (void)test5 {
    self.string = self.textField.text;
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 接收通知
- (void)tzAction:(NSNotification *)sender {
    
    self.textField.text = sender.userInfo[@"key"];
    
}

#pragma mark -  button
- (UIButton *)getButton:(NSString *)title :(SEL)method {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [button addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

//- (UITextField *)textField
//{
//    if (!_textField) {
//        _textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 150, 50)];
//        _textField.placeholder = @"请输入传递的值";
//        _textField.text = @"";
//        _textField.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
//        [self.view addSubview:_textField];
//    }
//    
//    return _textField;
//}
// 移除通知
- (void)dealloc  {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
