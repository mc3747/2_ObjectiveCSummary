//
//  Person.h
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, assign) int age;

+ (instancetype)person;


- (instancetype)initWithAge:(int)age;

+ (instancetype)personWithAge:(int)age;
@end
