//
//  Tools.m
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Tools.h"

@implementation Tools

/*
+ (instancetype)shareTools
{
    Tools *instance = [[self alloc] init];
    return instance;
}

static Tools *_instance = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}


- (id)copyWithZone:(NSZone *)zone{

    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

// MRC
- (oneway void)release
{

}

- (instancetype)retain
{
    return _instance;
}

- (NSUInteger)retainCount
{
    return  MAXFLOAT;
}
*/

implementationSingleton(Tools)

@end
