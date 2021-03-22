//
//  SGEventVC.m
//  SGEasyButtonExample
//
//  Created by kingsic on 2017/9/18.
//  Copyright © 2017年 kingsic. All rights reserved.
//
#import "SGEventVC.h"
#import "UIButton+category2.h"
#import "UIButton+SGCountdown.h"
#import "UIButton+SGImagePosition.h"

@interface SGEventVC ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation SGEventVC
// =====================================================
/*
 重复点击的情形：
 1，同一个界面，不同的按钮同时响应
    1.第一种方法，在AppDelegate中，添加如下：
    [[UIButton appearance] setExclusiveTouch:YES];

    2.第二种方法，为button写一个分类，设置属性button.exclusiveTouch = YES;

 2，同一个按钮，同时响应多次点击
    方法一 设置enabled或userInteractionEnabled属性：延时
    方法二 借助cancelPreviousPerformRequestsWithTarget:selector:object实现：延时
    方法三 通过runtime交换方法实现
 */
// =====================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.btn.timeInterval = 1;
}

- (IBAction)clickEvent:(UIButton *)sender {
    NSLog(@"连续点击我昂");
}


/** 方法二 */
- (void)tapBtn:(UIButton *)btn {
    NSLog(@"按钮点击了...");
    // 此方法会在连续点击按钮时取消之前的点击事件，从而只执行最后一次点击事件
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonClickedAction:) object:btn];
    // 多长时间后做某件事情
    [self performSelector:@selector(buttonClickedAction:) withObject:btn afterDelay:2.0];
}
 
- (void)buttonClickedAction:(UIButton *)btn {
    NSLog(@"真正开始执行业务 - 比如网络请求...");
}




@end
