//
//  main.m
//  自定义类工厂方法
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

//    Person *p = [[Person alloc] init];
//    Person *p1  = [Person person];
//    p1.age = 30;
    Person *p1 = [Person personWithAge:30];
    NSLog(@"age = %i", p1.age);
    /*
     自定义类工厂方法是苹果的一个规范, 一般情况下, 我们会给一个类提供自定义构造方法和自定义类工厂方法用于创建一个对象
     */
    
//    [[NSString alloc] init];
//    [NSString string];
//    
//    [[NSString alloc] initWithString:<#(NSString *)#>];
//    [NSString stringWithString:<#(NSString *)#>];
//    
//    [[NSArray alloc] init];
//    [NSArray array];
//    [NSArray alloc] initWithObjects:<#(id), ...#>, nil
//    [NSArray arrayWithObjects:<#(id), ...#>, nil]
    
    return 0;
}
