//
//  SingltonTest.m
//  单例
//
//  Created by gjfax on 2017/2/16.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "SingltonTest.h"

@implementation SingltonTest
#pragma mark - 创建单例的方式1（快速但片面，只能调用一个单例方法）
+ (SingltonTest *)shareInstance {
    // 1.定义一个静态变量来保存你类的实例确保在你的类里面保持全局
    static SingltonTest *_sharedInstance = nil;
    // 2.定义一个静态的dispatch_once_t变量来确保这个初始化存在一次
    static dispatch_once_t onceToken;
    // 3.用GCD来执行block初始化实例
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[SingltonTest alloc] init];
        _sharedInstance ->_age = 10;
        _sharedInstance ->_name = @"mc";
    });
    
    return _sharedInstance;

}

#pragma mark - 创建单例的方式2（复杂但全面，能使用单例方法和alloc init方法）
//// 注意这里用的是self，不要直接用类名写死，没有拓展性
//+ (instancetype)shareInstance
//{
//    return [[self alloc] init];
//}
//
//// 注意：创建对象：都是alloc、new、类方法创建，但内部本质还是[alloc init]，所以要考虑alloc内部所调用的方法
//static SingltonTest *_instance;
//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    
//    // 由于alloc方法内部会调用allocWithZone: 所以我们只需要保证在该方法只创建一个对象即可
//    dispatch_once(&onceToken,^{
//        
//        // 只执行1次的代码(这里面默认是线程安全的)
//        _instance = [super allocWithZone:zone];
//        _instance.age = 10;
//        _instance.name = @"mc";
//        
//    });
//    
//    return _instance;
//}
//
//// 因为copy方法必须通过实例对象调用, 所以可以直接返回_instance
//- (id)copyWithZone:(NSZone *)zone
//{
//    return _instance;
//}
//
//- (id)mutableCopyWithZone:(NSZone *)zone
//{
//    return _instance;
//}

#pragma mark - 创建单例的方式3（利用宏创建，）

//#define MCSingletonM \
//static id _instance;\
//\
//+ (instancetype)allocWithZone:(struct _NSZone *)zone\
//{\
//static dispatch_once_t onceToken;\
//dispatch_once(&onceToken, ^{\
//_instance = [super allocWithZone:zone];\
//});\
//return _instance;\
//}\
//\
//+ (instancetype)sharedInstance\
//{\
//static dispatch_once_t onceToken;\
//dispatch_once(&onceToken, ^{\
//_instance = [[self alloc]init];\
//});\
//return _instance;\
//}\
//\
//- (id)copyWithZone:(NSZone *)zone\
//{\
//return _instance;\
//}

@end
