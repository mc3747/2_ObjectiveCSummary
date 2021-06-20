//
//  Person.h
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
//    @public
    int _age;
    NSString *_name;
    double _height;
}

- (void)setAge:(int)age;
- (void)setName:(NSString *)name;
- (void)setHeight:(double)height;

- (int)age;
- (double)height;
- (NSString *)name;

- (void)test;

@end
