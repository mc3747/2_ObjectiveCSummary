//
//  Person.m
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Person.h"

// .h和.m之间切换 command  + control + ⬆️
@implementation Person
-(void)say
{
    NSLog(@"name = %@, age = %i", _name, _age);
}

- (void)signal:(Iphone *)phone
{
    [phone callWithNumber:12345678];
}
@end
