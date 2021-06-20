//
//  TimeManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/1.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TimeManager.h"

@implementation TimeManager
//获取当前时间戳  （以毫秒为单位）

+(NSString *)getNowTimeStamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    
    NSDate *datenow = [NSDate date];
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
    
}

+ (NSString *)getimeDifferenceStar:(NSString *)time1 End:(NSString *)time2 {
    
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss SSS";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitNanosecond;
    
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    
    // 4.输出结果
    return [NSString stringWithFormat:@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒%f毫秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second, cmps.nanosecond / 1000000.f];

}

@end
