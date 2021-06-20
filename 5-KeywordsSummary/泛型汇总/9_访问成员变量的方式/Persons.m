//
//  Person.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Persons.h"

@implementation Persons
- (void)setAge:(int)age
{
    _age = age;
}

- (void)setHeight:(double)height
{
    _height = height;
}

- (void)setName:(NSString *)name
{
    _name = name;
}

- (int)age
{
    return _age;
}

- (double)height
{
    return _height;
}

- (NSString *)name
{
    return _name;
}
@end
