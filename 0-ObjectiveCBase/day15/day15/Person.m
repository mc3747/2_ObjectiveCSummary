//
//  Person.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

- (void)dealloc
{
    NSLog(@"Person dealloc");
    // 注意:super dealloc一定要写到所有代码的最后
    // 一定要写在dealloc方法的最后面
    [super dealloc];
}
@end
