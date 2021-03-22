//
//  GCDOtherViewController.m
//  GCDDemo
//
//  Created by LeeMiao on 2019/4/2.
//  Copyright © 2019 LiMiao. All rights reserved.
//


#import "GCDOtherViewController.h"

typedef void(^comletionHandler)(NSString *status);

@interface GCDOtherViewController ()

@end

@implementation GCDOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = @"GCD信号量";
    
    NSArray *btnTitleArr = @[@"信号量基础",
                             @"信号量基础 信号量减少放入block中",
                             @"实现异步多线程并发任务的同步操作",
                             @"实现异步多线程Block任务的同步操作"];
    
    for (int i = 0; i < btnTitleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 100 + i * 40, [UIScreen mainScreen].bounds.size.width - 20, 30);
        [self.view addSubview:btn];
        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn addTarget:self action:@selector(btnClickActionWithSender:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
    };
    
}



- (void)btnClickActionWithSender:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
            [self showAlertViewToChoseSemValueHasBlock:NO];
        }
            break;
        case 1:{
            [self showAlertViewToChoseSemValueHasBlock:YES];
        }
            break;
        case 2:{
            [self semaphoreAsyncGlobalTask];
        }
            break;
        case 3:{
            [self semaphoreAsyncGlobalBlockTask];
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark - 选择初始值
- (void)showAlertViewToChoseSemValueHasBlock:(BOOL)hasBlock{
    UIAlertController *sheetContoller = [UIAlertController alertControllerWithTitle:@"选择你的信号量初始值" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    for (int i = 0; i < 5; i++) {
        NSString *titleStr = [NSString stringWithFormat:@"%d",i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (!hasBlock) {
                [self semaphoreTestMethodWithSemValue:i];
            }else{
                [self semaphoreBlockTestMethodWithSemValue:i];
            }
        }];
        [sheetContoller addAction:action];
    }
    [self presentViewController:sheetContoller animated:YES completion:nil];
}

#pragma mark - 信号量基础
- (void)semaphoreTestMethodWithSemValue:(long)semValue{
    NSLog(@"\n\n\n\n");
    NSLog(@"semaphoreTestMethod 总任务开启");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(semValue);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        NSLog(@"任务一开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务一 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务一 任务Block回掉完成 %@",status);
        }];
        
        NSLog(@"完成任务一 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    //任务2
    dispatch_async(quene, ^{
        NSLog(@"任务二开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务二 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务二 任务Block回掉完成 %@",status);
        }];
        NSLog(@"完成任务二 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    //任务3
    dispatch_async(quene, ^{
        NSLog(@"任务三开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务三 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务三 任务Block回掉完成 %@",status);
        }];
        NSLog(@"完成任务三 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    });
    
    NSLog(@"semaphoreTestMethod 总任务关闭");
}

#pragma mark - 信号量 + 并发回掉
- (void)semaphoreBlockTestMethodWithSemValue:(long)semValue{
    NSLog(@"\n\n\n\n");
    NSLog(@"semaphoreTestMethod 总任务开启");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(semValue);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        NSLog(@"任务一开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务一 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务一 任务Block回掉完成 %@",status);
            dispatch_semaphore_signal(semaphore);
        }];
        
        NSLog(@"完成任务一 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
    });
    //任务2
    dispatch_async(quene, ^{
        NSLog(@"任务二开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务二 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务二 任务Block回掉完成 %@",status);
            dispatch_semaphore_signal(semaphore);
        }];
        NSLog(@"完成任务二 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
    });
    //任务3
    dispatch_async(quene, ^{
        NSLog(@"任务三开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务三 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务三 任务Block回掉完成 %@",status);
            dispatch_semaphore_signal(semaphore);
        }];
        NSLog(@"完成任务三 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
    });
    
    NSLog(@"semaphoreTestMethod 总任务关闭");
}

#pragma mark - group 信号量
- (void)semaphoreGroupBlockTestMethodWithSemValue:(long)semValue{
    NSLog(@"\n\n\n\n");
    NSLog(@"semaphoreTestMethod 总任务开启");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(semValue);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(quene, ^{
        NSLog(@"任务一开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务一 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务一 任务Block回掉完成 %@",status);
            dispatch_semaphore_signal(semaphore);
        }];
        
        NSLog(@"完成任务一 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
    });
    //任务2
    dispatch_async(quene, ^{
        NSLog(@"任务二开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务二 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务二 任务Block回掉完成 %@",status);
            dispatch_semaphore_signal(semaphore);
        }];
        NSLog(@"完成任务二 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
    });
    //任务3
    dispatch_async(quene, ^{
        NSLog(@"任务三开始");
        NSInteger currentSem = dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"任务三 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"任务三 任务Block回掉完成 %@",status);
            dispatch_semaphore_signal(semaphore);
        }];
        NSLog(@"完成任务三 currentSem = %ld：当前线程：%@",currentSem ,[NSThread currentThread]);
    });
    
    NSLog(@"semaphoreTestMethod 总任务关闭");
}

#pragma mark - 实现异步多线程并发任务的同步操作
- (void)semaphoreAsyncGlobalTask{
    NSLog(@"\n\n\n\n");
    NSLog(@"semaphoreAsyncGlobalTask 总任务开启");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"任务执行 -> 开始线程：%@",[NSThread currentThread]);      // 打印当前线程
    __block NSInteger number = 0;
    dispatch_async(quene, ^{
        [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
        NSLog(@"任务执行 一  -> 结束 线程：%@",[NSThread currentThread]);      // 打印当前线程
        number = 100;
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"任务执行 二 -> 结束  线程：%@",[NSThread currentThread]);      // 打印当前线程
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"任务执行 三 -> 结束  线程：%@",[NSThread currentThread]);      // 打印当前线程
    NSLog(@"semaphoreAsyncGlobalTask 总任务关闭");
}


#pragma mark - 实现异步多线程并发带Block回掉任务的同步操作
- (void)semaphoreAsyncGlobalBlockTask{
    NSLog(@"\n\n\n\n");
    NSLog(@"semaphoreAsyncGlobalBlockTask 总任务开启");
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"任务执行 -> 开始线程：%@",[NSThread currentThread]);      // 打印当前线程
    dispatch_async(quene, ^{
        NSLog(@"Block任务执行 -> 开始线程：%@",[NSThread currentThread]);      // 打印当前线程
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"Block任务执行 一  -> 结束 线程：%@",[NSThread currentThread]);      // 打印当前线程
            dispatch_semaphore_signal(semaphore);
        }];
    });
    NSLog(@"任务执行 二 -> 结束  线程：%@",[NSThread currentThread]);      // 打印当前线程
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"任务执行 三 -> 结束  线程：%@",[NSThread currentThread]);      // 打印当前线程
    NSLog(@"semaphoreAsyncGlobalBlockTask 总任务关闭");
}





#pragma mark -
#pragma mark -  模拟网络请求回掉
/**
 模拟网络请求的回掉
 
 @param comletionHandler 模拟网络请求回掉
 */
- (void)netWorkingComletionHandler:(comletionHandler)comletionHandler{
    
    // 异步子线程 网络请求耗时操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSInteger sleepTimeInterval = [self getRandomNumber:1 to:5];
        NSString *randomNumber = [NSString stringWithFormat:@"当前线程是：%@ 随机等待：%ld秒",[NSThread currentThread],sleepTimeInterval];
        [NSThread sleepForTimeInterval:sleepTimeInterval];
        
        // 异步主线程 网络请求回掉请求内容
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (comletionHandler) {
                comletionHandler(randomNumber);
            }
        });
        
    });
}


/**
 获取随机数
 
 @param from 随机数最小值
 @param to 随机数最大值
 @return 最小值与最小值之间的随机数
 */
- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

@end
