//
//  Person.h
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCopying, NSMutableCopying>

@property (nonatomic, assign) int age;

@property (nonatomic, copy) NSString *name;
@end
