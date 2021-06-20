//
//  main.m
//  字符串搜索
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

//    NSString *str = @"http://www.520it.com/img/lnj.gif";
    // 1.判断是否以什么开头
    /*
    // 本质就是从字符串的第一个字符开始匹配, 只要不匹配就返回NO
    if ([str hasPrefix:@"http://"]) {
        NSLog(@"是一个URL");
    }else
    {
        NSLog(@"不是一个URL");
    }
     */
    
    // 2.判断是否以什么结尾
    /*
    // 本质就是从字符串的最后一个字符开始匹配, 只要不匹配就返回NO
    if ([str hasSuffix:@".gif"]) {
        NSLog(@"动态图片");
    }else{
        NSLog(@"不是动态图片");
    }
     */
    
    // 3.判断字符串中是否包含520it.com
    /*
    NSString *str = @"abcd";
    // 只要str中包含该字符串, 那么就会返回该字符串在str中的起始位置以及该字符串的长度
    // location从0开始 , length从1开始
    // 如果str中没有需要查找的字符串, 那么返回的range的length=0, location = NSNotFound
    NSRange range =  [str rangeOfString:@"lnj"];
//    if (range.location == NSNotFound) {
    if (range.length == 0){
        NSLog(@"str中没有需要查找的字符串");
    }else{
        NSLog(@"str中有需要查找的字符串");
        NSLog(@"location = %lu, length = %lu", range.location, range.length);
    }
     */
    return 0;
}
