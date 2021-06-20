//
//  main.m
//  单例
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tools.h"

int main(int argc, const char * argv[]) {

    /*
    // 单例就是无论怎么创建都只能有一个实例对象
    // 如果地址相同就代表着是同一个实例对象
    Tools *t1 = [[Tools alloc] init]; //内部会调用allocWithZone
    Tools *t2 = [Tools new];// [[alloc] init]  allocWithZone
    Tools *t3 = [Tools shareInstance];
    
    Tools *t4 = [t3 copy];
    Tools *t5 = [t3 mutableCopy];
    
    NSLog(@"%p, %p, %p, %p, %p", t1, t2, t3, t4, t5);
    
    */
    
    Tools *t2 = [[Tools alloc] init];
    [t2 retain];
    [t2 retain];
    [t2 retain];
    [t2 retain];
    [t2 retain];
    
    NSLog(@"retainCount = %lu", [t2 retainCount]);
    NSLog(@"t2 = %p", t2);
    [t2 release];
    
    Tools *t1 = [Tools shareInstance];
    NSLog(@"retainCount = %lu", [t2 retainCount]);
    NSLog(@"t1 = %p", t1);
    [t1 release];
    
    
    return 0;
}
