//
//  Account.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Account.h"

@implementation Account

-(void)dealloc
{
    NSLog(@"%s", __func__);
    [_email release];
    [_pwd release];
    [super dealloc];
}
@end
