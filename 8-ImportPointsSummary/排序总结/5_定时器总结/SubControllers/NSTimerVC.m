//
//  TwoVC.m
//  JX_GCDTimer
//
//  Created by ylgwhyh on 16/4/29.
//  Copyright © 2016年 com.joeyxu. All rights reserved.
//

#import "NSTimerVC.h"

@interface NSTimerVC ()
@property (nonatomic, weak) NSTimer  *timer;
@property (nonatomic, assign) NSUInteger testCount;
@end

@implementation NSTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [self addTestButton];
    _testCount = 0;
    
}

#pragma mark - 添加按钮
- (void)addTestButton {
    UIButton *testBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 80, 30)];
    [testBtn1 setTitle:@"添加" forState:UIControlStateNormal];
    [testBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [testBtn1 addTarget:self action:@selector(addTimer) forControlEvents:UIControlEventTouchUpInside];
    [testBtn1 setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:testBtn1];
    
    
    UIButton *testBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(250, 150, 80, 30)];
    [testBtn2 setTitle:@"移除" forState:UIControlStateNormal];
    [testBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [testBtn2 addTarget:self action:@selector(removeTimer) forControlEvents:UIControlEventTouchUpInside];
    [testBtn2 setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:testBtn2];
    
    UIButton *testBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 220, 80, 30)];
    [testBtn3 setTitle:@"暂停" forState:UIControlStateNormal];
    [testBtn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [testBtn3 addTarget:self action:@selector(pauseTimer) forControlEvents:UIControlEventTouchUpInside];
    [testBtn3 setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:testBtn3];
    
    
    UIButton *testBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(250, 220, 80, 30)];
    [testBtn4 setTitle:@"继续" forState:UIControlStateNormal];
    [testBtn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [testBtn4 addTarget:self action:@selector(restartTimer) forControlEvents:UIControlEventTouchUpInside];
    [testBtn4 setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:testBtn4];
    
}
#pragma mark - 执行方法
- (void)testTimerAction{
    _testCount ++;
    NSLog(@"NSTimer定时器执行%lu次",(unsigned long)_testCount);
}

- (void)testTimerAction:(int )age and:(NSString *)parameterString{
    _testCount ++;
    NSLog(@"NSTimer定时器执行%lu次",(unsigned long)_testCount);
    NSLog(@"%d",age);
    NSLog(@"%@",parameterString);
    
}
#pragma mark - 添加定时器
- (void)addTimer {
  
// 添加方法1
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testTimerAction) userInfo:nil repeats:YES];
    
// 添加方法2
//    __weak  typeof (self)weakSelf = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [weakSelf testTimerAction];
//    }];
    
// 添加方法3
    //创建一个函数签名，这个签名可以是任意的,但需要注意，签名函数的参数数量要和调用的一致。
    NSMethodSignature * sig  = [[self class] instanceMethodSignatureForSelector:@selector(testTimerAction:and:)];
    //通过签名初始化
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sig];
    //设置target
    [invocation setTarget:self];
    //设置selecteor
    [invocation setSelector:@selector(testTimerAction:and:)];
    // 设置第一个参数
    int age = 18;
    [invocation setArgument:&age atIndex:2];
    // 设置第二个参数
    NSString *dsc = @"第二个参数字符串";
    [invocation setArgument:&dsc atIndex:3];
    //消息调用
    [invocation invoke];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 invocation:invocation repeats:YES];
    
    // 添加方法4
        // 使用NSTimer timer开头的方法与上边的方法一样使用，但要主动添加后才执行，加上一句话：[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [self.timer fire];
    
    
    //    UIScrollView 拖动时执行的是 UITrackingRunLoopMode，会导致暂停定时器，等恢复为 NSDefaultRunLoopMode 时才恢复定时器。
    //    所以如果需要定时器在 UIScrollView 拖动时也不影响的话，建议添加到 UITrackingRunLoopMode 或 NSRunLoopCommonModes 中：
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: UITrackingRunLoopMode];
    
}
#pragma mark - 暂停定时器(只有重复执行的情况下，即repeats为yes，此方法才管用)
- (void)pauseTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
#pragma mark - 恢复定时器(只有重复执行的情况下，即repeats为yes，此方法才管用)
- (void)restartTimer {
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantPast]];
    }
}
#pragma mark - 销毁定时器
- (void)removeTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        NSLog(@"移除定时器");
    }
}

- (void)dealloc{
    [self removeTimer];
    NSLog(@"销毁整个界面");
    
}
@end
