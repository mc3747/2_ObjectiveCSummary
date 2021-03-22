//
//  ProtocolDelegateVC.m
//  排序总结
//
//  Created by gjfax on 2018/9/10.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ProtocolDelegateVC.h"
#import "TimerDelegate.h"
@interface ProtocolDelegateVC ()<UpdateAlertDelegate>

@end

@implementation ProtocolDelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandColor;
    TimerDelegate *timer = [[TimerDelegate alloc] init];
    timer.delegate = self; //设置委托实例
    [timer startTheTimer];//启动定时器
}

//"被委托对象"实现协议声明的方法,由"委托对象"调用
- (void)updateAlert
{
     UIAlertController *actionAlert = [UIAlertController alertControllerWithTitle:@"标题" message:@"注释信息,没有就写nil" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionAlert addAction:action1];
    [self presentViewController:actionAlert animated:YES completion:^{
        
    }];
}



@end
