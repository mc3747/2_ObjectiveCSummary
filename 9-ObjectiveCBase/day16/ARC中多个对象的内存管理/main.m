//
//  main.m
//  ARC中多个对象的内存管理
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"
int main(int argc, const char * argv[]) {

    Person *p = [[Person alloc] init];
    Dog *d = [[Dog alloc] init];
    
    p.dog = d;
    d.owner = p;
    
    d = nil;
    
    NSLog(@"-----");
    
    p = nil;
    
    return 0;
}
