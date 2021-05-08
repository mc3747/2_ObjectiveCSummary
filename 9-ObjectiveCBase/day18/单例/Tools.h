//
//  Tools.h
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject<NSCopying, NSMutableCopying>
// 一般情况下创建一个单利对象都有一个与之对应的类方法
// 一般情况下用于创建单利对象的方法名称都以share开头, 或者以default开头
+ (instancetype)shareInstance;

@end
