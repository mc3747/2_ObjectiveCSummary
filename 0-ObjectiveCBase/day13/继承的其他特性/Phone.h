//
//  Phone.h
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

// 被继承的这个类我们称之为父类/ 超类
@interface Phone : NSObject
{
    int _cpu;
}

// 打电话
- (void)signalWithNumber:(NSString *)number;

// 发短信
- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content;

// 打印品牌信息
+ (void)brand;
@end
