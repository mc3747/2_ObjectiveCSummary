//
//  ViewController.m
//  NSInvocation & 方法名 & performSelector
//
//  Created by gjfax on 2018/3/29.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "CallMethodViewController.h"

@interface CallMethodViewController ()

@end

@implementation CallMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testInvocation];
}

/*
 调用方法的4种方式 ：
 1，调用方法；
 2，performSelector方法
 3，函数指针
 4，NSInvocation的方法
 */

#pragma mark -  1，[obj methodName]

- (void)testMethod {
    
    /*缺点：不能通过方法名字符串来执行方法 */
    
    /*优点：调用多个参数 */
    
}


#pragma mark -  2， [obj performSelector......]
- (void)testPerform {
//⚠️总结：该方法写法简便，但会报警告“performSelector may cause a leak because its selector is unknown”，因为返回值不确定，该如何处理，建议使用指针
    
/*优点：可以通过方法名字符串来执行方法 */
    
         //不传参数，不报警
//    [self performSelector:@selector(printName)];
    
    
        //传参数，报警(最多两个参数)
    SEL selector = NSSelectorFromString(@"printName::");
//    [self performSelector:selector withObject:@"TOM" withObject:@"Cat"];
    
    //使用延时就不会报警
    [self performSelector:selector withObject:@"tom" afterDelay:0.1f];
    
 
/*缺点：不可以调用多个参数 ：最多两个参数*/

    
}
#pragma mark -  3，函数指针的方法
- (void)testPointer {
    
//不传参数，不报警（函数指针，可以穿任意多个参数）
    //    SEL selector = NSSelectorFromString(@"printName");
    //    IMP imp = [self methodForSelector:selector];
    //    void (*func)(id, SEL) = (void *)imp;
    //    func(self, selector);
    
//传参数，不报警（函数指针，可以穿任意多个参数）
        SEL selector = NSSelectorFromString(@"printName:::");
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL, NSString *, NSString *,NSString *) = (void *)imp;
        func(self, selector,@"Tom",@"Cat",@"Dog");
    
}

#pragma mark -  4，NSInvocation
- (void)testInvocation {
    //签名
    SEL selector = NSSelectorFromString(@"returnPrintName:::");
    NSMethodSignature *signature =  [self methodSignatureForSelector:selector];
    //invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    //selector的两种写法
//    invocation.selector = @selector(printName:::);
    
    //传参
    NSString *arg1 = @"Tom";
    NSString *arg2 = @"Cat";
    NSString *arg3 = @"Dog";
        //invocation 有2个隐藏参数，target与selector，所以 argument 从2开始
    [invocation setArgument:&arg1 atIndex:2];
    [invocation setArgument:&arg2 atIndex:3];
    [invocation setArgument:&arg3 atIndex:4];
    [invocation invoke];
    
    //获取返回值
    if (signature.methodReturnLength > 0) {
        //利用指针来保存，防止崩掉
        void *tempResultSet;
        [invocation getReturnValue:&tempResultSet];
        NSString *result =  (__bridge NSString *)tempResultSet;
        NSLog(@"%@",result);
        //若采用如下方法，则会崩掉
//        NSString *result = nil;
//        [invocation getReturnValue:&result];
//        NSLog(@"%@",result);
    };
    
}

#pragma mark -  5，runTime传值
- (void)testRunTime {
    
}

#pragma mark -  各种测试方法
- (void)printName {
    NSLog(@"我的名字");
}

- (void)printName:(NSString *)name1 {
    NSLog(@"我的名字%@",name1);
}

- (void)printName:(NSString *)name1 :(NSString *)name2  {
    NSLog(@"我的名字%@和%@",name1,name2);
}

- (void)printName:(NSString *)name1 :(NSString *)name2 :(NSString *)name3  {
    NSLog(@"我的名字%@,%@和%@",name1,name2,name3);
}
- (NSString *)returnPrintName:(NSString *)name1 :(NSString *)name2 :(NSString *)name3  {
    NSLog(@"我的名字%@,%@和%@",name1,name2,name3);
    return [NSString stringWithFormat:@"%@,%@,%@",name1,name2,name3];
}


@end
