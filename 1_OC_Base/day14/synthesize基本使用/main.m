//
//  main.m
//  synthesize基本使用
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    Person *p = [Person new];
    [p setAge:88];
//    NSLog(@"age = %i , p->_age = %i", [p age], p->_age);
//    NSLog(@"_age = %i, _number = %i", p->_age, p->_number);
    NSLog(@"_age = %i, age = %i", p->_age, p->age);
    
    return 0;
}
