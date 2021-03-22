//
//  StaticAndExternManager.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "StaticAndExternManager.h"

@implementation StaticAndExternManager

int num;

static int age;

extern int height;

#pragma mark -  1,全局变量


+ (void)overallVariableTest {
    
}


#pragma mark -  2，局部变量

+ (void)partVariableTest {
    
}

#pragma mark -  内部函数和外部函数

+ (void)functionTest {
    
}
extern void test()
{
    
}
static void demo()
{
    
}
@end
