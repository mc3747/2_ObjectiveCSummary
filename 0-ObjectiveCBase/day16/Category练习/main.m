//
//  main.m
//  Category练习
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+NJ.h"

/*
int countWithStr(NSString *str)
{
    int count = 0;
    for (int i = 0; i < str.length; ++i) {
        unichar c = [str characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            count++;
        }
    }
    return count;
}
 */

int main(int argc, const char * argv[]) {
    /*
     已知一个字符串, 要求找出字符串中所有的阿拉伯数字
     @"a123jj46kfd5jlwf7ld";
     
     1.计数器思想, 定义一个变量保存结果
     2.遍历字符串, 取出字符串中所有的字符
     */
    NSString *str = @"a1jj46kf1d5jlwf7l9d8";
    /*
//    unichar c = [str characterAtIndex:1];
//    NSLog(@"%c", c);
    int count = 0;
    for (int i = 0; i < str.length; ++i) {
        unichar c = [str characterAtIndex:i];
//        NSLog(@"%c", c);
        if (c >= '0' && c <= '9') {
            count++;
        }
    }
     */
//    int count = countWithStr(str);
//    int count = [NSString countWithStr:str];
    int count = [str count];
    NSLog(@"count = %i", count);
    return 0;
}
