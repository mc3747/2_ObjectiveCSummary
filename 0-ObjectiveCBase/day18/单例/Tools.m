//
//  Tools.m
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Tools.h"

@implementation Tools

+ (instancetype)shareInstance
{
    Tools *instance = [[self alloc] init];
    return instance;
}


static Tools *_instance = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{

    /*
    // 当前代码在多线程中可能会出现问题
    NSLog(@"%s", __func__);
    // 由于所有的创建方法都会调用该方法, 所以只需要在该方法中控制当前对象只创建一次即可
    if (_instance == nil) {
        NSLog(@"创建了一个对象");
        _instance = [[super allocWithZone:zone] init];
    }
    return _instance;
     */
    
    // 以下代码在多线程中也能保证只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

// copyWithZone方法用什么调用? 对象
- (id)copyWithZone:(NSZone *)zone{
//    Tools *t = [[[self class] allocWithZone:zone] init];
//    return t;
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
//    Tools *t = [[[self class] allocWithZone:zone] init];
//    return t;
    
    return _instance;
}

- (oneway void)release
{
    // 为保证整个程序过程中只有一份实例, \
    在这个方法中什么都不做
}

- (instancetype)retain
{
    return _instance;
}

- (NSUInteger)retainCount
{
//    return 1;
    // 注意: 为了方便程序员之前沟通, 一般情况下不会在单例中返回retainCount = 1
    // 而是返回一个比较大得值
    return  MAXFLOAT;
}


@end
