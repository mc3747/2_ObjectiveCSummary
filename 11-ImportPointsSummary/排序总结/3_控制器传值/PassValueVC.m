//
//  PassValueVC.m
//  排序总结
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "PassValueVC.h"
#import "ReceiveValueVC.h"
#import "GCD_Singleton.h"

@interface PassValueVC ()<PassValueDelegate>
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, strong) ReceiveValueVC *receiveVC;
@end

@implementation PassValueVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//     self.textField.text = [GCD_Singleton sharedInstance].value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 150, 50)];
    textField.placeholder = @"请输入传递的值";
    textField.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.6];
    textField.tintColor = [UIColor redColor];
    [self.view addSubview:textField];
    _textField = textField;
    
    SEL sel1 = @selector(test1);
    SEL sel2 = @selector(test2);
    SEL sel3 = @selector(test3);
    SEL sel4 = NSSelectorFromString(@"test4");
    SEL sel5 = NSSelectorFromString(@"test5");
    SEL sel6 = NSSelectorFromString(@"test6");
    SEL sel7 = NSSelectorFromString(@"test7");
    SEL sel8 = NSSelectorFromString(@"test8");
    
    UIButton *btn1 = [self getButton:@"1,正向属性传值" :sel1];
    btn1.frame = CGRectMake(20, 200, 150, 50);
    
    UIButton *btn2 = [self getButton:@"2,反向代理传值" :sel2];
    btn2.frame = CGRectMake(200, 200, 150, 50);
    
    UIButton *btn3 = [self getButton:@"3,反向block传值" :sel3];
    btn3.frame = CGRectMake(20, 270, 150, 50);
    
    UIButton *btn4 = [self getButton:@"4,正向通知传值" :sel4];
    btn4.frame = CGRectMake(200, 270, 150, 50);
    // 接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotificationAction:) name:@"B2A" object:nil];
    
    UIButton *btn5 = [self getButton:@"5,正向单例传值" :sel5];
    btn5.frame = CGRectMake(20, 340, 150, 50);
   
    UIButton *btn6 = [self getButton:@"6,KVO传值" :sel6];
    btn6.frame = CGRectMake(200, 340, 150, 50);
    
    UIButton *btn7 = [self getButton:@"7,KVC传值" :sel7];
    btn7.frame = CGRectMake(20, 410, 150, 50);
    
    UIButton *btn8 = [self getButton:@"8,NSUserDefaults传值" :sel8];
    btn8.frame = CGRectMake(200, 410, 150, 50);
}


#pragma mark -  1，属性传值
- (void)test1 {
    ReceiveValueVC *vc = [[ReceiveValueVC alloc] init];
    vc.string = _textField.text;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  2，代理传值
- (void)test2 {
    ReceiveValueVC *vc = [[ReceiveValueVC alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  3，block传值
- (void)test3 {
    ReceiveValueVC *vc = [[ReceiveValueVC alloc] init];
    __weak __typeof(self) weakSelf = self;
    // block 回调接收
    [vc setBlock:^(NSString *string){
        weakSelf.textField.text = string;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  4，通知传值
- (void)test4 {
    //保证通知的注册在post之前（ReceiveValueVC的init方法里就注册了）
    ReceiveValueVC *vc = [[ReceiveValueVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"A2B" object:nil userInfo:@{@"key":self.textField.text}];
}

#pragma mark -  5,单例传值
- (void)test5 {
    ReceiveValueVC *vc = [[ReceiveValueVC alloc] init];
    [GCD_Singleton sharedInstance].value = self.textField.text;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -  6,KVO传值
- (void)test6 {
    _receiveVC = [[ReceiveValueVC alloc] init];
    [_receiveVC addObserver:self forKeyPath:@"string" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController pushViewController:_receiveVC animated:YES];
}
#pragma mark -  7，KVC传值
- (void)test7 {
    /**
     KVC 传值：这里只能传A传到B （因为 B在A页面提前初始化）
     B 有个属性 string
     用B对象 给B属性赋值（回顾下OC中KVC赋值 就理解了）
     这里forkey 一定要和B 属性名字一致 （也可以用@"_string"）因为是属性
     */
    _receiveVC = [[ReceiveValueVC alloc] init];
    [_receiveVC setValue:self.textField.text forKey:@"string"];
    [self.navigationController pushViewController:_receiveVC animated:YES];
}
#pragma mark -  8，NSUserDefaults传值
- (void)test8 {
    _receiveVC = [[ReceiveValueVC alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"text"];
    [self.navigationController pushViewController:_receiveVC animated:YES];
}

#pragma mark -  代理回调
- (void)passValue:(NSString *)string {
    
    self.textField.text = string;
}


#pragma mark -  通知接收值
- (void)NotificationAction:(NSNotification *)sender {
    
    self.textField.text = sender.userInfo[@"key"];
}

#pragma mark -  移除通知 和KVO
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.receiveVC removeObserver:self forKeyPath:@"string"];
}

#pragma mark -  KVO的回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"string"]) {
        self.textField.text = self.receiveVC.string;
    }
}


#pragma mark -  获取按钮
- (UIButton *)getButton:(NSString *)title :(SEL)method {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button addTarget:self action:method forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}
@end
