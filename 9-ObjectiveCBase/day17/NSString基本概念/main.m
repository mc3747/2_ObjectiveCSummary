//
//  main.m
//  NSString基本概念
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    /*
     1.如何创建一个NSString对象, 字符串
     */
    
    // 1.通过@""直接创建
    // 如果通过@""创建字符串, 那么会将字符串放到常量区中
    // 如果是字符串常量, 那么只要内容相同 , 不会重复创建
    NSString *str1 = @"lnj";
    
    // 2.通过alloc或者类工厂方法创建
    // 如果是通过alloc或者类工厂方法创建, 那么会将字符串放到堆区中
//    NSString *str2 = [[NSString alloc] initWithString:@"lnj"];
//    NSString *str3 = [NSString stringWithFormat:@"lmj"];
//    NSString *str3 = [[NSString alloc] initWithString:@"lmj"];
    NSString *str3 = [NSString stringWithFormat:@"age is %i", 10];
    
    
    NSString *str4 = @"lnj";
    NSLog(@"str1 = %p, str4 = %p", str1, str4);
    
//    NSString *str5 = [NSString stringWithFormat:@"lmj"];
//    NSString *str5 = [[NSString alloc] initWithString:@"lmj"];
    NSString *str5 = [NSString stringWithFormat:@"age is %i", 10];
    NSLog(@"str3 = %p, str5 = %p", str3, str5);

    return 0;
}
