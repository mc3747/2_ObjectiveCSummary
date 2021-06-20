//
//  NSString+NJ.m
//  day16
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "NSString+NJ.h"

@implementation NSString (NJ)

+ (int)countWithStr:(NSString *)str
{
    int count = 0;
    for (int i = 0; i < str.length; ++i) {
        unichar c = [str characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            count++;
        }
    }
    return count;
}

- (int)count
{
    int number = 0;
    for (int i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (c >= '0' && c <= '9') {
            number++;
        }
    }
    return number;
}
@end
