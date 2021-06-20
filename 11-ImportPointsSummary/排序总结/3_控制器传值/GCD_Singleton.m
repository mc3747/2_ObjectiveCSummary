//
//  GCD_Singleton.m
//  排序总结
//
//  Created by gjfax on 2018/6/11.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "GCD_Singleton.h"

@implementation GCD_Singleton
+ (instancetype)sharedInstance
{
    // 1.定义一个静态变量来保存你类的实例确保在你的类里面保持全局
    static GCD_Singleton *_sharedInstance = nil;
    
    // 2.定义一个静态的dispatch_once_t变量来确保这个初始化存在一次
    static dispatch_once_t onceToken;
    
    // 3.用GCD来执行block初始化实例
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[GCD_Singleton alloc] init];
        _sharedInstance ->_value = @"10";
    });
    
    return _sharedInstance;
}

@end
