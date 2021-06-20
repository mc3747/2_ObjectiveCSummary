//
//  InstanceManager.m
//  泛型汇总
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "InstanceManager.h"
#import "Persons.h"

@implementation InstanceManager

- (void)test {
     Persons *p = [Persons new];
    
//方法1:->访问
     p->_age = 30;
     NSLog(@"age = %i",p->_age);
    
//方法2:setter和getter方法
    [p setAge:40];
    NSLog(@"age = %i",[p age]);
    
//方法3:点语法(本质是调用了setter和getter方法)
    p.age = 50;
    NSLog(@"age = %i",p.age);
}
@end
