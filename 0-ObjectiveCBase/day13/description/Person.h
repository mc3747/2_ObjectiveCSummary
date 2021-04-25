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
    int _age;
    double _height;
    double _weight;
    NSString *_name;
    NSString *_tel;
    NSString *_email;
}


- (void)setAge:(int)age;
- (void)setHeigth:(double)height;
- (void)setWeight:(double)weight;
- (void)setName:(NSString *)name;
- (void)setTel:(NSString *)tel;
- (void)setEmail:(NSString *)email;

- (int)age;
- (double)height;
- (double)weight;
- (NSString *)name;
- (NSString *)tel;
- (NSString *)email;
@end
