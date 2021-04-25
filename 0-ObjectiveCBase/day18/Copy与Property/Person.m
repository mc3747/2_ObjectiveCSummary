//
//  Person.m
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Person.h"


@implementation Person


- (void)dealloc
{
    // 只要给block发送一条release消息, block中使用到的对象也会收到该消息
    Block_release(_pBlock);
    NSLog(@"%s", __func__);
    [super dealloc];
}
@end
