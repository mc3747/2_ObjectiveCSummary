//
//  Author.m
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Author.h"

@implementation Author

- (void)dealloc
{
    NSLog(@"%s", __func__);
    [_name release];
    [_icon release];
    [_account release];
    [super dealloc];
}
@end
