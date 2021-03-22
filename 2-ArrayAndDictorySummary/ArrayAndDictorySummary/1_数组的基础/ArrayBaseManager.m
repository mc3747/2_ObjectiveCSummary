//
//  ArrayBaseManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ArrayBaseManager.h"

@implementation ArrayBaseManager
#pragma mark -  1，不可变数组的创建
+ (void)getArray {
    
// 1,直接创建不可变数组
    NSArray *arr1 = @[@"bei", @"jing", @"huan", @"ying", @"nin"];
    
// 2,对象方法创建
    NSArray *arr2 = [[NSArray alloc] init];
    
    // 和 arr1 的地址不相同
    NSArray *arr3 = [[NSArray alloc] initWithArray:arr1];
    
    NSArray *arr4 = [[NSArray alloc] initWithObjects:@"bei", @"jing", @"huan", @"ying", @"nin", nil];
    
// 3,类方法创建
    
    NSArray *arr5 = [NSArray array];
    
    // 和 arr1 的地址不相同
    NSArray *arr6 = [NSArray arrayWithArray:arr1];
    
    // 创建只有一个元素(id)的数组
    NSArray *arr7 = [NSArray arrayWithObject:@"qian"];
    
    NSArray *arr8 = [NSArray arrayWithObjects:@"bei", @"jing", @"huan", @"ying", @"nin", nil];
    
// 4,从文件创建字符串
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Desktop/test.txt"];
    
    NSArray *arr9 = [[NSArray alloc] initWithContentsOfFile:path];
    NSArray *arr10 = [NSArray arrayWithContentsOfFile:path];
    
// 5,从 Url 创建字符串
    NSURL *url = [NSURL URLWithString:[@"file://" stringByAppendingString:[NSHomeDirectory()
                                                                           stringByAppendingString:@"/Desktop/test.txt"]]];
    
    NSArray *arr11 = [[NSArray alloc] initWithContentsOfURL:url];
    NSArray *arr12 = [NSArray arrayWithContentsOfURL:url];
    
// 6,泛型定义
    // 指明数组中存放的是 NSString 类型数据
    NSArray<NSString *> *arr13 = @[@"bei", @"jing", @"huan", @"ying", @"nin"];
    
    // 指明数组中存放的是 NSNumber 类型数据
    NSArray<NSNumber *> *arr14 = @[@2, @4, @6, @8, @10];
}

#pragma mark -  2，可变数组的创建
+ (void)getMutableArray {
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
    
// 3,注意: 不能通过@[]来创建一个可变数组, 因为@[]创建出来的是一个不可变的数组
}

#pragma mark -  3，数组：元素/下标的获取
+ (void)getElement {
    NSArray *arr = @[@"bei", @"jing", @"huan", @"ying", @"nin"];
    
//数组获取子数组
    // subarrayWithRange
    NSArray *arr3 = [arr subarrayWithRange:NSMakeRange(2, 2)];
    
//数组获取元素
    // 方法1:[]
    id object1 = arr[1];
    
    // 方法2:下标获取元素：objectAtIndex
    id object2 = [arr objectAtIndex:2];
    
    // 方法3:第一个或者最后一个元素
    id lastObject =  [arr lastObject];
    id firstObject = [arr firstObject];
    
    // 方法4:元素获取下标：objectAtIndex
     NSUInteger index = [arr indexOfObject:@"huan"];
    
}

#pragma mark -  4，数组转字符串 / 字符串转数组
+(void)getArrayWithString {
 //数组转字符串
    NSArray *arr1 = @[@"lnj", @"lmj", @"jjj"];
    //直接链接
    NSString *str1 = [NSString pathWithComponents:arr1];
    //中间拼接特定字符串后连接
    NSString *str2 = [arr1 componentsJoinedByString:@"**"];
    
 // 字符串转数组
    NSString *str3 = @"lnj**lmj**jjj";
    NSArray *arr2 = [str3 componentsSeparatedByString:@"**"];
}
@end
