//
//  main.m
//  getter-setter方法练习
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Kline.h"
/*
 
 要求设计一个股票软件
 提供一个设置最大值. 和一个最小值, 以及获取平局值的方法
 */
int main(int argc, const char * argv[]) {
    
    // 1.创建K线类
    Kline *kp = [Kline new];
    // 2.设置属性
    [kp setMin:100];
    [kp setMax:200];
//    [kp setAverage:<#(int)#>]
    // 3.获取属性的值
    NSLog(@"min = %i, max = %i, average = %i", [kp min], [kp max], [kp average]);
    
    [kp average];
    [kp average];
    [kp average];
    [kp average];
    return 0;
}
