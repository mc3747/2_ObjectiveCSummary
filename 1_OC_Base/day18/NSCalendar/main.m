//
//  main.m
//  NSCalendar
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    // 1.获取当前时间的年月日时分秒
    /*
    // 获取当前时间
    NSDate *now = [NSDate date];
    NSLog(@"now = %@", now);
    // 日历
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    // 利用日历类从当前时间对象中获取 年月日时分秒(单独获取出来)
    // components: 参数的含义是, 问你需要获取什么?
    // 一般情况下如果一个方法接收一个参数, 这个参数是是一个枚举 , 那么可以通过|符号, 连接多个枚举值
    NSCalendarUnit type = NSCalendarUnitYear |
                          NSCalendarUnitMonth |
                          NSCalendarUnitDay |
                          NSCalendarUnitHour |
                         NSCalendarUnitMinute |
                        NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar1 components:type fromDate:now];
    NSLog(@"year = %ld", cmps.year);
    NSLog(@"month = %ld", cmps.month);
    NSLog(@"day = %ld", cmps.day);
    NSLog(@"hour = %ld", cmps.hour);
    NSLog(@"minute = %ld", cmps.minute);
    NSLog(@"second = %ld", cmps.second);
     */

    // 2.比较两个时间之间的差值, 比较相差多少年多少月多少日多少小时多少分钟多少秒
    
    // 2.1过去的一个时间
    NSString *str = @"2015-06-29 07:05:26 +0000";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    NSDate *date = [formatter dateFromString:str];
    // 2.2当前的时间
    NSDate *now = [NSDate date];
    
    NSLog(@"date = %@", date);
    NSLog(@"now = %@", now);
    
    // 2.3比较两个时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:type fromDate:date toDate:now options:0];
    NSLog(@"%ld年%ld月%ld日%ld小时%ld分钟%ld秒钟", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return 0;
}
