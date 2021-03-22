//
//  ButtonTransferParameterVC.m
//  排序总结
//
//  Created by gjfax on 2019/12/13.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "ButtonTransferParameterVC.h"
#import <objc/runtime.h>
#import "UIButton+PassValue.h"
#import "MyButton.h"

@interface ButtonTransferParameterVC ()

@end

@implementation ButtonTransferParameterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:
        ({
        UIButton *button1 = [self buttonWithFrame:CGRectMake(0, 60, 120, 40) title:@"1,绑定tag"];
        [button1 setTag:5];
        [button1 addTarget:self action:@selector(method1:) forControlEvents:UIControlEventTouchUpInside];
        button1;
        })
     ];
    
    [self.view addSubview: ({
        UIButton *button2 = [self buttonWithFrame:CGRectMake(150, 60, 120, 40) title:@"2,动态绑定"];
        [button2 addTarget:self action:@selector(method2:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(button2, @"myBtn", @{@"sender":@6}, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        button2;
        
    })];
    
    [self.view addSubview: ({
        UIButton *button3 = [self buttonWithFrame:CGRectMake(0, 110, 120, 40) title:@"3,分类"];
        button3.paramDic = @{@"sender":@"7"};
         [button3 addTarget:self action:@selector(method3:) forControlEvents:UIControlEventTouchUpInside];
        button3;})];
    
    [self.view addSubview: ({
        MyButton *button4 = [[MyButton alloc] initWithFrame:CGRectMake(150, 110, 120, 40)];
        [button4 setTitle:@"4,自定义button" forState:UIControlStateNormal];
          [button4.titleLabel setTextColor:Wonderful_RedColor4];
          [button4 setBackgroundColor:Wonderful_GreenColor1];
          [button4.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
        button4.paramDic = @{@"sender":@"7"};
        [button4 addTarget:self action:@selector(method4:) forControlEvents:UIControlEventTouchUpInside];
        button4;
    })];
  
   
}

#pragma mark -  方法1：tag区分
- (void)method1:(UIButton *)button{
    NSLog(@"button的tag：%li",[button tag]);
}

#pragma mark -  方法2：动态绑定，关联对象
//关联对象的方法，也可以用在tableViewCell上的button，绑定参数，在整个tableView中只用响应一个方法
- (void)method2:(UIButton *)button{
    NSDictionary *dic = objc_getAssociatedObject(button, @"myBtn");
    NSLog(@"button的tag：%@",dic[@"sender"]);
}
#pragma mark -  方法3：分类
- (void)method3:(UIButton *)button{
    NSLog(@"button的tag：%@",button.paramDic[@"sender"]);
}
#pragma mark -  方法4：自定义button
- (void)method4:(UIButton *)button{
    NSLog(@"button的tag：%@",button.paramDic[@"sender"]);
}

-(UIButton *)buttonWithFrame:(CGRect )frame title:(NSString *)title {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setTextColor:Wonderful_RedColor4];
    [button setBackgroundColor:Wonderful_GreenColor1];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    return button;
}
@end
