//
//  ViewController.m
//  GCDDemo
//
//  Created by LeeMiao on 2019/4/2.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "GCDBaseViewController.h"

typedef NS_ENUM(NSUInteger, GCDButtonClickActionType) {
    GCDButtonClickActionTypeSyncWithConcrrent,
    GCDButtonClickActionTypeAsyncWithConcrrent,
    GCDButtonClickActionTypeSyncAndSerial,
    GCDButtonClickActionTypeAsyncAndSerial,
    GCDButtonClickActionTypeAsyncAndMainThread,
    GCDButtonClickActionTypeSyncAndMainThread,
    GCDButtonClickActionTypeAsyncAndBarrier,
    GCDButtonClickActionTypeGCDAfter,
    GCDButtonClickActionTypeGroupNotify,
    GCDButtonClickActionTypeGroupWaiter,
    GCDButtonClickActionTypeGroupEnterAndLeave,
};


typedef void(^comletionHandler)(NSString *status);

@interface GCDBaseViewController ()

@end

@implementation GCDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = @"GCD基础";
    
    
    NSArray *btnTitleArr = @[@"同步执行Sync + 并发队列Concurrent",
                             @"异步执行Async + 并发队列Concurrent",
                             @"同步执行Sync + 串行队列Serial",
                             @"异步执行Async + 串行队列Serial",
                             @"异步执行Async + 主线程",
                             @"同步执行sync + 主线程",
                             @"异步执行Async + 栅栏barrier",
                             @"延时执行",
                             @"队列组group notify",
                             @"队列组group wait",
                             @"队列组group enter and leave"];
    
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
    GCDButtonClickActionType actionType  = sender.tag;
    switch (actionType) {
        case GCDButtonClickActionTypeSyncWithConcrrent:
            NSLog(@"\n\n\n\n\n同步执行sync + 并发队列CONCURRENT\n");
            [self syncConcurrentTask];
            break;
        case GCDButtonClickActionTypeAsyncWithConcrrent:
            NSLog(@"\n\n\n\n\n异步执行async + 并发队列CONCURRENT\n");
            [self asyncConcurrentTask];
            break;
        case GCDButtonClickActionTypeSyncAndSerial:
            NSLog(@"\n\n\n\n\n同步执行sync + 串行队列Serial\n");
            [self syncSerialTask];
            break;
        case GCDButtonClickActionTypeAsyncAndSerial:
            NSLog(@"\n\n\n\n\n异步执行async + 串行队列Serial\n");
            [self asyncSerialTask];
            break;
        case GCDButtonClickActionTypeSyncAndMainThread:
            NSLog(@"\n\n\n\n\n同步执行sync + 主线程\n");
            [self syncMainThreadTask];
            break;
        case GCDButtonClickActionTypeAsyncAndMainThread:
            NSLog(@"\n\n\n\n\n异步执行async + 主线程\n");
            [self asyncMainThreadTask];
            break;
        case GCDButtonClickActionTypeAsyncAndBarrier:
            NSLog(@"\n\n\n\n\n异步执行sync + 栅栏Barrier\n");
            [self asyncBarrierTask];
            break;
        case GCDButtonClickActionTypeGCDAfter:
            NSLog(@"延时执行");
            [self excuteGCDAfterMehod];
            break;
        case GCDButtonClickActionTypeGroupNotify:
            NSLog(@"GroupNotify");
            [self asyncGroupNotifyTask];
            break;
        case GCDButtonClickActionTypeGroupWaiter:
            NSLog(@"GroupWait");
            [self asyncGroupWaitTask];
            break;
        case GCDButtonClickActionTypeGroupEnterAndLeave:
            NSLog(@"GroupEnterAndLeave");
            [self asyncGroupEnterAndLeaveTask];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark -  dispatch_group_notify

- (void)asyncGroupNotifyTask{
    
    NSLog(@"当前线程是：%@ asyncGroupNotifyTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    NSLog(@"当前线程是：%@ asyncGroupNotifyTask---继续",[NSThread currentThread]);  // 打印当前线程
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
        NSLog(@"当前线程是：%@ asyncGroupNotifyTask---结束",[NSThread currentThread]);  // 打印当前线程
    });

}


#pragma mark -
#pragma mark -  dispatch_group_wait
- (void)asyncGroupWaitTask{
    
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---继续",[NSThread currentThread]);  // 打印当前线程
    // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---结束",[NSThread currentThread]);  // 打印当前线程
}


#pragma mark -
#pragma mark -  dispatch_group_enter dispatch_group_leave
- (void)asyncGroupEnterAndLeaveTask{
    
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---第一个网络请求",[NSThread currentThread]);  // 打印当前线程
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"第一并发  当前线程是：%@",[NSThread currentThread]);  // 打印当前线程
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"第一并发  发回掉结束 %@",status);
            dispatch_group_leave(group);
        }];
    });
  
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---第二个网络请求",[NSThread currentThread]);  // 打印当前线程
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"第二并发  当前线程是：%@",[NSThread currentThread]);  // 打印当前线程
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"第二并发  发回掉结束 %@",status);
            dispatch_group_leave(group);
        }];
    });
    
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---第三个网络请求",[NSThread currentThread]);  // 打印当前线程
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"第三并发  当前线程是：%@",[NSThread currentThread]);  // 打印当前线程
        [self netWorkingComletionHandler:^(NSString *status) {
            NSLog(@"第三并发  发回掉结束 %@",status);
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"网络回掉任务全部完成  当前线程是：%@",[NSThread currentThread]);  // 打印当前线程
    });
    NSLog(@"当前线程是：%@ asyncGroupWaitTask---结束",[NSThread currentThread]);  // 打印当前线程
}





#pragma mark -
#pragma mark -  同步执行sync + 并发队列CONCURRENT
- (void)syncConcurrentTask{
    
    NSLog(@"当前线程是：%@ syncConcurrentTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_queue_t syncQueue = dispatch_queue_create("syncQueuex", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(syncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
        
    });
    
    dispatch_sync(syncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_sync(syncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    NSLog(@"当前线程是：%@ syncConcurrentTask---结束",[NSThread currentThread]);  // 打印当前线程
}

#pragma mark -
#pragma mark -  异步执行async + 并发队列CONCURRENT
- (void)asyncConcurrentTask{
    
    NSLog(@"当前线程是：%@ asyncConcurrentTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_queue_t asyncQueue = dispatch_queue_create("asyncQueuex", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(asyncQueue, ^{
        
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
            
        };
    });
    
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    NSLog(@"当前线程是：%@ asyncConcurrentTask---结束",[NSThread currentThread]);  // 打印当前线程
}


#pragma mark -
#pragma mark -  同步执行sync + 串行队列Serial
- (void)syncSerialTask{
    
    NSLog(@"当前线程是：%@ syncSerialTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_queue_t syncQueue = dispatch_queue_create("syncQueuex", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(syncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_sync(syncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_sync(syncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    NSLog(@"当前线程是：%@ syncSerialTask---结束",[NSThread currentThread]);  // 打印当前线程
}


#pragma mark -
#pragma mark -  异步执行async + 串行队列Serial
- (void)asyncSerialTask{
    
    NSLog(@"当前线程是：%@ asyncSerialTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_queue_t asyncQueue = dispatch_queue_create("asyncQueuex", DISPATCH_QUEUE_SERIAL);
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
            
        };
    });
    
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    NSLog(@"当前线程是：%@ asyncSerialTask---结束",[NSThread currentThread]);  // 打印当前线程
}



#pragma mark -
#pragma mark -  异步执行async + 主线程
- (void)asyncMainThreadTask{
    
    NSLog(@"当前线程是：%@ asyncMainThreadTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    NSLog(@"当前线程是：%@ asyncMainThreadTask---结束",[NSThread currentThread]);  // 打印当前线程
}




#pragma mark -
#pragma mark -  同步执行sync + 主线程
- (void)syncMainThreadTask{
    NSLog(@"当前线程是：%@ syncMainThreadTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
            
        };
    });
    
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    NSLog(@"当前线程是：%@ syncMainThreadTask---结束",[NSThread currentThread]);  // 打印当前线程
}



#pragma mark -
#pragma mark - 栅栏方法
- (void)asyncBarrierTask{
    NSLog(@"当前线程是：%@ asyncBarrierTask---开始",[NSThread currentThread]);  // 打印当前线程
    dispatch_queue_t asyncQueue = dispatch_queue_create("asyncQueuex", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第一并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第一并发 -%d- 发回掉结束 %@",i,status);
            }];
            
        };
    });
    
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第二并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第二并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_barrier_async(asyncQueue, ^{
        // 追加任务 barrier
        for (int i = 0; i < 2; i++) {
            NSLog(@"barrier -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"barrier -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第三并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第三并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    
    dispatch_async(asyncQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"第四并发 -%d- 当前线程是：%@",i,[NSThread currentThread]);  // 打印当前线程
            [self netWorkingComletionHandler:^(NSString *status) {
                NSLog(@"第四并发 -%d- 发回掉结束 %@",i,status);
            }];
        };
    });
    NSLog(@"当前线程是：%@ asyncBarrierTask---结束",[NSThread currentThread]);  // 打印当前线程
}


#pragma mark -
#pragma mark - 延时等待
- (void)excuteGCDAfterMehod{
    NSLog(@"当前线程是：%@ excuteAfterMehod---开始",[NSThread currentThread]);  // 打印当前线程
    
    // 子线程等待3秒
    dispatch_time_t globalQueueTimeAfter = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(globalQueueTimeAfter, globalQueue, ^{
        NSLog(@"当前线程是：%@ excuteAfterMehod---子线程继续",[NSThread currentThread]);  // 打印当前线程

        // 主线程等待1秒
        dispatch_time_t mainQueueTimeAfter = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_after(mainQueueTimeAfter, mainQueue, ^{
            NSLog(@"当前线程是：%@ excuteAfterMehod---主线程继续",[NSThread currentThread]);  // 打印当前线程
        });
    });
    
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


