//
//  main.m
//  NSMutableArray
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    /*
    // 创建一个空得数组
    NSMutableArray *arrM = [NSMutableArray array];
    NSLog(@"%@", arrM);
    // 如何添加
    [arrM addObject:@"lnj"];
    // 将指定数组中的元素都取出来, 放到arrM中
    // 并不是将整个数组作为一个元素添加到arrM中
    [arrM addObjectsFromArray:@[@"lmj", @"jjj"]];
    // 注意: 以下是将整个数组作为一个元素添加
//    [arrM addObject:@[@"lmj", @"jjj"]];
    NSLog(@"%@", arrM);
    // 如何插入
    [arrM insertObject:@"xcq" atIndex:1];
    NSLog(@"%@", arrM);
    
    NSRange range = NSMakeRange(2, 2);
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
    // 插入一组数据, 指定数组需要插入的位置, 和插入多少个
    [arrM insertObjects:@[@"A", @"B"] atIndexes:set];
     NSLog(@"%@", arrM);
    
    // 如何删除
    [arrM removeObjectAtIndex:0];
     NSLog(@"%@", arrM);
    
    [arrM removeLastObject];
    NSLog(@"%@", arrM);
    
    [arrM removeObject:@"A"];
     NSLog(@"%@", arrM);
    
    // 如何替换
    [arrM replaceObjectAtIndex:1 withObject:@"M"];
    NSLog(@"%@", arrM);
    
    // 如何获取
    NSLog(@"%@", [arrM objectAtIndex:0]);
    NSLog(@"%@", arrM[0]);
    
    // 替换
    arrM[0] = @"ZS";
    NSLog(@"%@", arrM);
    */
    
    // 注意: 不能通过@[]来创建一个可变数组, 因为@[]创建出来的是一个不可变的数组
    // 如果把一个不可变数组当做一个可变数组来使用, 会引发一个运行时的错误
    NSMutableArray *arrM = @[@"lnj", @"lmj"];
    [arrM addObject:@"JJJ"];
    
    return 0;
}
