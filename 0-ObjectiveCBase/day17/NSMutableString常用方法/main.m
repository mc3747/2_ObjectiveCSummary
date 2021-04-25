//
//  main.m
//  NSMutableString常用方法
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    NSMutableString *strM = [NSMutableString stringWithFormat:@"www.520it.com.520"];
    
    // 1.在字符串后面添加/image
    /*
    [strM appendString:@"/image"];
//    [strM appendFormat:@"/age is %i", 10];
    NSLog(@"strM = %@", strM);
    */
    // 2.删除字符串中的520
    /*
    // 技巧: 在开发中, 我们经常利用rangeOfString和deleteCharactersInRange方法配合起来删除指定的字符串
    // 2.1先查找出520在字符串中的位置
    NSRange range = [strM rangeOfString:@"520"];
    // 2.2删除520
    [strM deleteCharactersInRange:range];
    NSLog(@"strM = %@", strM);
     */
    
    // 3.在520前面插入love这个单词
    /*
    // insertString : 需要插入的字符串
    // atIndex: 从哪里开始插入
    NSRange range = [strM rangeOfString:@"520"];
    [strM insertString:@"love" atIndex:range.location];
    NSLog(@"strM = %@", strM);
     */
    
    // 4.要求将字符串中的520替换为530
    // 注意: 如果是调用NSString的字符串替换方法, 不会修改原有字符串, 而是生产一个新的字符串
//    NSString *newStr =[strM stringByReplacingOccurrencesOfString:@"520" withString:@"530"];
    
    // 注意: 一般情况下OC方法要求传入一个参数如果没有*, 大部分都是枚举
    //      一般情况下如果不想使用枚举的值, 可以传入0, 代表按照系统默认的方式处理
    // OccurrencesOfString: 需要替换的字符串
    // withString: 用什么替换
    // options: 替换时的搜索方式
    // range: 搜索的范围
    // 返回值: 代表替换了多少个字符串
    NSUInteger count = [strM replaceOccurrencesOfString:@"520" withString:@"530" options:0 range:NSMakeRange(0, strM.length)];
    NSLog(@"strM = %@", strM);
    NSLog(@"count = %lu", count);
    
//    NSLog(@"newStr = %@", newStr);
    return 0;
}
