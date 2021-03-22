//
//  MoreAlertManageVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "MoreAlertManageVC.h"
#import "MoreAlertManageTableVC.h"
#import "MyBaseAlertView.h"
#import "MyOneView.h"
#import "MyTwoView.h"
#import "MyThreeView.h"

@interface MoreAlertManageVC ()
@property (strong, nonatomic) UIButton *normalButton;
@property (strong, nonatomic) UIButton *pushButton;
@property (strong, nonatomic) UIButton *presentButton;
@property (strong, nonatomic) UITextField *otherTextField;
@property (strong, nonatomic) UIButton *otherButton;
@property (nonatomic,assign) dispatch_queue_t myQueue;
@property (nonatomic,assign) NSInteger alertCount;
@end

@implementation MoreAlertManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.normalButton];
    [self.view addSubview:self.pushButton];
    [self.view addSubview:self.presentButton];
    [self.view addSubview:self.otherButton];
    [self.view addSubview:self.otherTextField];
    
    self.normalButton.frame = CGRectMake(50, 50, 100, 50);
    self.pushButton.frame = CGRectMake(50, 150, 100, 50);
    self.presentButton.frame = CGRectMake(50, 250, 100, 50);
    self.otherButton.frame = CGRectMake(50, 350, 150, 50);
    self.otherTextField.frame = CGRectMake(250, 350, 100, 50);
}
#pragma mark -  普通加锁
- (void)onNormalButtonClicked:(UIButton *)button {
    //创建一个队列，串行并行都可以，主要为了操作信号量
    dispatch_queue_t queue = dispatch_queue_create("com.se7en.alert", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        //创建一个初始为0的信号量
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        //第一个弹框，UI的创建和显示，要在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框1" message:@"第一个弹框" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //点击Alert上的按钮，我们发送一次信号。
                dispatch_semaphore_signal(sema);
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        });
        
        //等待信号触发，注意，这里是在我们创建的队列中等待
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //上面的等待到信号触发之后，再创建第二个Alert
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框2" message:@"第二个弹框" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                dispatch_semaphore_signal(sema);
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        });
        
        //同理，创建第三个Alert
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框3" message:@"第三个弹框" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                dispatch_semaphore_signal(sema);
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        });
    });
   
}
#pragma mark -  push更多
- (void)onPushButtonClicked:(UIButton *)button {
    MoreAlertManageTableVC *vc = [MoreAlertManageTableVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -  present更多
- (void)onPresentButtonClicked:(UIButton *)button {
    MoreAlertManageTableVC *vc = [MoreAlertManageTableVC new];
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark -  导出view
- (void)onOtherButtonClicked:(UIButton *)button {
    self.alertCount = [self.otherTextField.text integerValue];
      
       NSLog(@"开始执行");
        [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
              NSLog(@"执行完毕");
          }];

}

-(bool)isShowAlert{
    if (self.alertCount > 0) {
        self.alertCount --;
        return YES;
    }else{
        return NO;
    };
}
- (void)showSerialQueueAlertViewCompletion:(void(^)(BOOL finished))completion{
    
    NSLog(@"开始执行  弹框 ：%@",[NSThread currentThread]);
    //异步  这里会开启新的线程
    //为保证 在同一个线程 必须确保queue 是同一个同步队列
    dispatch_async(self.myQueue, ^{
        //创建一个初始为0的信号量
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSLog(@"串行队列执行 第一个 弹框 ：%@",[NSThread currentThread]);
        //创建第1个Alert UI的创建和显示，要在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"串行队列 主线程 执行 第一个 弹框 ：%@",[NSThread currentThread]);
            if ([self isShowAlert]) {
                MyOneView *view2 = [[MyOneView alloc] init];
                view2.title = [NSString stringWithFormat:@"第一个view"];
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                alertView2.animationType = MyBaseAlertViewAnimationTypeMoveFromBottomToBottom;
                [alertView2 showContentView:view2];
                [self.view addSubview:alertView2];
                view2.actionBlock = ^(UIButton *sender) {
                    [alertView2 dissmissContentView];
                    //点击Alert上的按钮，我们发送一次信号。
                    dispatch_semaphore_signal(sema);
                };
            }else{
                // 如果无需显示 直接发送信号量
                dispatch_semaphore_signal(sema);
            }
            
        });
       
        //等待信号触发，注意，这里是在我们创建的队列中等待，创建第N个Alert
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self isShowAlert]) {
                
                MyTwoView *view2 = [[MyTwoView alloc] init];
                MyBaseAlertView *alertView2 = [[MyBaseAlertView alloc] init];
                view2.title = [NSString stringWithFormat:@"第二个view"];

                alertView2.animationType = MyBaseAlertViewAnimationTypeMoveFromBottomToTop;
                [alertView2 showContentView:view2];
                [self.view addSubview:alertView2];
                view2.actionBlock = ^(UIButton *sender) {
                    [alertView2 dissmissContentView];
                    dispatch_semaphore_signal(sema);
                };
            }else{
                dispatch_semaphore_signal(sema);
            }
            
        });
        
        //同理，创建第N个Alert
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self isShowAlert]) {
                MyThreeView *view3 = [[MyThreeView alloc] init];
                view3.title = [NSString stringWithFormat:@"第三个view"];
                MyBaseAlertView *alertView3 = [[MyBaseAlertView alloc] init];
                alertView3.animationType = MyBaseAlertViewAnimationTypeMoveFromBottomToTop;
                [alertView3 showContentView:view3];
                [self.view addSubview:alertView3];
                view3.actionBlock = ^(UIButton *sender) {
                    [alertView3 dissmissContentView];
                    dispatch_semaphore_signal(sema);
                };
            }else{
                dispatch_semaphore_signal(sema);
            }
        });
        
        // 最终执行完毕 执行完毕回掉 同时也是为了衔接最后一个alert 和 下一轮的第一个alert 不然会出现同时弹出两个alert 的情况
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"执行finished block 回掉");
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(sema);
            if (completion) {
                completion(YES);
            }
        });
    });
    NSLog(@"添加完所有提示框");
}



- (dispatch_queue_t)myQueue{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("alertViewDemo", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

- (UIButton *)normalButton {
    if (!_normalButton) {
        _normalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_normalButton setTitle:@"普通加锁" forState:UIControlStateNormal];
        _normalButton.backgroundColor = [UIColor blackColor];
        [_normalButton addTarget:self action:@selector(onNormalButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _normalButton;
}
- (UIButton *)pushButton {
    if (!_pushButton) {
        _pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pushButton setTitle:@"Push更多" forState:UIControlStateNormal];
        _pushButton.backgroundColor = [UIColor blackColor];
        [_pushButton addTarget:self action:@selector(onPushButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}

- (UIButton *)presentButton {
    if (!_presentButton) {
        _presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_presentButton setTitle:@"Present更多" forState:UIControlStateNormal];
        _presentButton.backgroundColor = [UIColor blackColor];
        [_presentButton addTarget:self action:@selector(onPresentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _presentButton;
}

- (UIButton *)otherButton {
    if (!_otherButton) {
        _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherButton setTitle:@"show出不同类型的view" forState:UIControlStateNormal];
        _otherButton.backgroundColor = [UIColor blackColor];
        [_otherButton.titleLabel adjustsFontSizeToFitWidth];
        [_otherButton addTarget:self action:@selector(onOtherButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _otherButton;
}
- (UITextField *)otherTextField {
    if (!_otherTextField) {
        _otherTextField = [[UITextField alloc] init];
        _otherTextField.placeholder = @"弹框弹出的次数";
        _otherTextField.backgroundColor = [UIColor greenYellow];
    }
    return _otherTextField;
}
@end
