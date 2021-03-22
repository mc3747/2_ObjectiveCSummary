//
//  DicBaseManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "DicBaseManager.h"

@implementation DicBaseManager
#pragma mark -  1，不可变字典的创建
+ (void)getDic {
    
// 1,直接创建不可变字典
    NSDictionary *dic1 = @{@"key1":@"value1", @"key2":@"value2"};
    
// 2,对象方法创建
    NSDictionary *dic2 = [[NSDictionary alloc] init];
    
    // 和 dic1 的地址不相同
    NSDictionary *dic3 = [[NSDictionary alloc] initWithDictionary:dic1];
    
    NSDictionary *dic4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSDictionary *dic5 = [[NSDictionary alloc] initWithObjects:@[@"value1", @"value2", @"value3",]
                                                       forKeys:@[@"key1", @"key2", @"key3"]];
    
// 3,类方法创建
    
    NSDictionary *dic6 = [NSDictionary dictionary];
    
    // 和 dic1 的地址不相同
    NSDictionary *dic7 = [NSDictionary dictionaryWithDictionary:dic1];
    
    NSDictionary *dic8 = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    NSDictionary *dic9 = [NSDictionary dictionaryWithObject:@"value1" forKey:@"key1"];
    NSDictionary *dic10 = [NSDictionary dictionaryWithObjects:@[@"value1", @"value2", @"value3",]
                                                      forKeys:@[@"key1", @"key2", @"key3"]];
    
// 4,从 文件 创建字符串
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Desktop/test.txt"];
    NSDictionary *dic11 = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary *dic12 = [NSDictionary dictionaryWithContentsOfFile:path];
    
// 5,从 Url 创建字符串
    NSURL *url = [NSURL URLWithString:[@"file://" stringByAppendingString:[NSHomeDirectory()
                                                                           stringByAppendingString:@"/Desktop/test.txt"]]];
    NSDictionary *dic13 = [[NSDictionary alloc] initWithContentsOfURL:url];
    NSDictionary *dic14 = [NSDictionary dictionaryWithContentsOfURL:url];
    
// 6,泛型创建
    NSDictionary<NSString *, NSNumber *> *dic15 = @{@"key1":@3, @"key2":@5};
}
#pragma mark -  2,可变字典的创建
+ (void)getMutableDic {
// 1,对象方法创建
    /*
     创建指定长度的数组，预先分配空间，提高效率，实际长度可大于指定长度
     */
    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithCapacity:0];
    
// 2,类方法创建
    /*
     创建指定长度的数组，预先分配空间，提高效率，实际长度可大于指定长度
     */
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:0];
    
// 3,不能使用@{}来创建一个可变的字典
}

#pragma mark -  元素的获取
+ (void)getElements {
    
/*1，通过key获取value */
NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];
    
    // 通过 key 找对应的 value
    NSLog(@"%@", [dic objectForKey:@"key1"]);
    
    // 以下标的方式找 key 找对应的 value
    NSLog(@"%@", dic[@"key2"]);
    
    // key 没有对应的 value 时用 notFoundMarker 参数代替
    NSArray *arr = [dic objectsForKeys:@[@"key1", @"key1", @"key3"] notFoundMarker:@"not-Found"];
    
/*2，通过value获取key */
      NSLog(@"%@", [dic allKeysForObject:@"value2"]);

/*3，所有keys */
    NSLog(@"%@", [dic allKeys]);
 
/*4，所有values */
    NSLog(@"%@", [dic allValues]);
    
}
@end
