//
//  NSThreadVC.m
//  WHMultiThreadDemo
//  https://github.com/remember17/WHMultiThreadDemo
//  Created by 吴浩 on 2017/7/6.
//  Copyright © 2017年 wuhao. All rights reserved.
//  http://www.jianshu.com/p/7649fad15cdb

#import "NSThreadVC.h"
@interface NSThreadVC()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end

@implementation NSThreadVC

#pragma mark -  创建线程
- (IBAction)createNSThread1:(id)sender {
    /** 方法一，需要start */
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"NSThread1"];
    // 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
    [thread1 start];
}

- (IBAction)createNSThread2:(id)sender {
    /** 方法二，创建好之后自动启动 */
    [NSThread detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"NSThread2"];
}

- (IBAction)createNSThread3:(id)sender {
    /** 方法三，隐式创建，直接启动 */
    [self performSelectorInBackground:@selector(doSomething3:) withObject:@"NSThread3"];
}

- (void)doSomething1:(NSObject *)object {
    // 传递过来的参数
    NSLog(@"doSomething1参数：%@， 线程：%@",object,[NSThread currentThread]);
}

- (void)doSomething2:(NSObject *)object {
    NSLog(@"doSomething2参数：%@， 线程：%@",object,[NSThread currentThread]);
}

- (void)doSomething3:(NSObject *)object {
    NSLog(@"doSomething3参数：%@， 线程：%@",object,[NSThread currentThread]);
}

#pragma mark -  阻塞线程

- (IBAction)stopThreadAction:(id)sender {
    //记录开始时间
    NSLog(@"\n Start Time:%@, \n Current Thread: %@, \n Main Thread: %@", [NSDate date], [NSThread currentThread], [NSThread mainThread]);
    SEP_LINE;
    self.label1.text = [self generateString1];
    self.label2.text = [self generateString2];
    self.label3.text = [self generateString3];
    //记录结束时间
    NSLog(@"\n End Time:%@, \n Current Thread: %@, \n Main Thread: %@", [NSDate date], [NSThread currentThread], [NSThread mainThread]);
    SEP_LINE;
}
-(NSString *) generateString1{
    //阻塞主进程
    [NSThread sleepForTimeInterval:2.0];
    
    NSString *string = @"hello world!";
    return string;
}

-(NSString *) generateString2{
    //阻塞主进程
    [NSThread sleepForTimeInterval:2.0];
    
    NSString *string = @"I am Apple!";
    return string;
}

-(NSString *) generateString3{
    //阻塞主进程
    [NSThread sleepForTimeInterval:2.0];
    
    NSString *string = @"2016!";
    return string;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSThread";
}

@end
