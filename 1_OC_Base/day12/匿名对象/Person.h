//
//  Person.h
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Iphone.h"

@interface Person : NSObject
{
    @public
    int _age; // 年龄
    NSString *_name; // 姓名
}
- (void)say;
// 打电话方法
// phone 电话对象, 只有有了电话对象才能打电话
- (void)signal:(Iphone *)phone;

@end
