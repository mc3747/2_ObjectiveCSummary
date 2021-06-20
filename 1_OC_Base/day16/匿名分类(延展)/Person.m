//
//  Person.m
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Person.h"

@interface Person ()
{
    int _age;
}

- (void)say;

@end

@implementation Person
//{
//    int _age;
//}

-(void)eat
{
    NSLog(@"%s", __func__);
}

- (void)say
{
    NSLog(@"age = %i", _age);
}
@end
