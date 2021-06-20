//
//  Person.m
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"

@implementation Person

- (void)findHourse
{
    NSLog(@"学生想找房子");
    // 通知代理帮他找房子
    if ([self.delegate respondsToSelector:@selector(personFindHourse:)]) {
        [self.delegate personFindHourse:self];
    }
}

@end
