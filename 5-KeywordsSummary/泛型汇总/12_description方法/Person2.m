//
//  Person2.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "Person2.h"

@implementation Person2

- (void)setAge:(int)age
{
    _age = age;
}

- (int)age
{
    return _age;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"对象方法%i", _age];
}

+ (NSString *)description
{
    return [NSString stringWithFormat:@"类方法"];
}
@end
