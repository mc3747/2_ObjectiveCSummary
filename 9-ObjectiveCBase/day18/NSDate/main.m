//
//  main.m
//  NSDate
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    // 1.NSDate创建和基本概念
    /*
    // 只要是通过date方法创建的时间对象, 对象中就保存了当前的时间
    NSDate *now = [NSDate date];
    NSLog(@"now = %@", now);
    // 在now的基础上追加多少秒
//    NSDate *date = [now dateByAddingTimeInterval:10];
//    NSLog(@"date = %@", date);
    
    // 1.获取当前所处的时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 2.获取当前时区和指定时间的时间差
    NSInteger seconds = [zone secondsFromGMTForDate:now];
//    NSLog(@"seconds = %lu", seconds);
    
    NSDate *newDate = [now dateByAddingTimeInterval:seconds];
    NSLog(@"newDate = %@", newDate);
     */
    
    // 2.时间格式化  NSDate --> NSString
    /*
    // xxxx年xx月xx日 xx小时xx分钟xx秒
    // xxxx/xx/xx  xx/xx/xx
    // xx/xx/xxxx  xx/xx/xx
    NSDate *now = [NSDate date];
    
    // 创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 告诉时间格式化对象, 按照什么样的格式来格式化时间
    // yyyy 年
    // MM 月
    // dd 日
    // HH 24小时  hh 12小时
    // mm 分钟
    // ss 秒钟
    // Z 时区
//    formatter.dateFormat = @"yyyy年MM月dd日 HH时mm分ss秒 Z";
    formatter.dateFormat = @"MM-dd-yyyy HH-mm-ss";
    
    // 利用时间格式化对象对时间进行格式化
    NSString *res = [formatter stringFromDate:now];
    NSLog(@"res = %@", res);
    */
    
    // NSString --> NSDate
    NSString *str = @"2015-06-29 07:05:26 +0000";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 注意: 如果是从NSString格式化为NSDate, 那么dateFormat的格式, 必须和字符串中的时间格式一致, 否则可能转换失败
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    NSDate *date = [formatter dateFromString:str];
    NSLog(@"%@", date);
    
    return 0;
}
