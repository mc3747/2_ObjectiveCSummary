//
//  main.m
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

    Person *p = [Person new];
    // 无论使用什么成语变量修饰符修饰成员变量, 我们都可以在其它类中看到这个变量
    // 只不过有得修饰符修饰的变量我们不能操作而已
//    p->_age;
//    p->_height;
//    p->_name;
//    p->_weight;
//    [p test];
    
//    id pp = [Person new];
//    [pp test];
    
    [p performSelector:@selector(test)];
    
    return 0;
}
