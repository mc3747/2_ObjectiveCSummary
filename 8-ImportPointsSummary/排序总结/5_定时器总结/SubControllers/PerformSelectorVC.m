//
//  PerformSelectorVC.m
//  JX_GCDTimer
//
//  Created by ylgwhyh on 16/5/1.
//  Copyright © 2016年 com.joeyxu. All rights reserved.
//

#import "PerformSelectorVC.h"

@implementation PerformSelectorVC

/*performSelector方法必须要在主线程中使用.可以传递参数.可以取消操作,不能暂停. */

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self normalDelayMethod];

    [self synDelayMethod];

}
- (void)normalDelayMethod {
    //不带参数
    
    [self performSelector:@selector(delayDo:) withObject:nil afterDelay:1.0f];
    //带参数
    [self performSelector:@selector(delayDo:) withObject:@"abc" afterDelay:1.0f];
}
#pragma mark - 取消延时
- (void)cancelDelayAction {
    // 取消所有延迟执行操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //取消不传参的方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayDo:) object:nil];
    //取消传参的方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayDo:) object:@"abc"];
}
#pragma mark - 延时操作
- (void)delayDo : (id)sender {
    NSLog(@"do:%@",sender);
}
#pragma mark - 同步异步延时
- (void)synDelayMethod {
    //该方法在那个线程调用，那么run就在哪个线程执行（当前线程），通常是主线程。
    [self performSelector:@selector(testAction) withObject:self afterDelay:3.0];
    
    // 队列
    dispatch_queue_t queue = dispatch_queue_create("wendingding", 0);
    
    // 同步函数执行
    //    dispatch_sync(queue, ^{
    //                 [self performSelector:@selector(test) withObject:nil afterDelay:1.0];
    //             });
    
    // 异步函数不执行
    dispatch_async(queue, ^{
        [self performSelector:@selector(test) withObject:nil afterDelay:1.0];
    });
    
    NSLog(@"测试打印延时");

}
#pragma mark - 同步延时
- (void)testAction{
    NSLog(@"performSelector执行延时");
}
#pragma mark - 异步延时（行不通）
-(void)test{
    NSLog(@"同步执行延时，异步不执行延时%@",[NSThread currentThread]);
}

@end
