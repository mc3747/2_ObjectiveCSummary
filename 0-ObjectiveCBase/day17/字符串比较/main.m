//
//  main.m
//  字符串比较
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    NSString *str1 = @"abc";
    NSString *str2 = @"ABC";
    
    /*
    // 比较两个字符串的"内容"是否相同
    BOOL flag = [str1 isEqualToString:str2];
    NSLog(@"flag = %i", flag);
    
    // 下面这个方法, 是比较两个字符串的"地址"是否相同
    flag = (str1 == str2);
    NSLog(@"flag = %i", flag);
     */
    
    // 比较字符串的大小
    /*
    // NSOrderedAscending  前面的小于后面的
    // NSOrderedSame,  两个字符串相等
    // NSOrderedDescending  前面的大于后面的
    switch ([str1 compare:str2]) {
        case NSOrderedAscending:
            NSLog(@"str1小于str2");
            break;
        case NSOrderedSame:
            NSLog(@"str1等于str2");
            break;
        case NSOrderedDescending:
            NSLog(@"str1大于str2");
            break;
        default:
            break;
    }
     */
    
    /*
    // 忽略大小写进行比较
    switch ([str1 caseInsensitiveCompare:str2]) {
        case NSOrderedAscending:
            NSLog(@"str1小于str2");
            break;
        case NSOrderedSame:
            NSLog(@"str1等于str2");
            break;
        case NSOrderedDescending:
            NSLog(@"str1大于str2");
            break;
        default:
            break;
    }
     */
    return 0;
}
