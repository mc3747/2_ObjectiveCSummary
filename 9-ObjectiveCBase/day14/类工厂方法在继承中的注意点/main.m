//
//  main.m
//  类工厂方法在继承中的注意点
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[]) {

    /*
    Student *stu = [Student person]; // [[Person alloc] init];
    Person *p = [Person person];
//    stu.age = 55;
//    NSLog(@"age = %i", stu.age);
    stu.no = 888;
    NSLog(@"no = %i", stu.no);
     */
    Student *stu = [Student personWithAge:30];
    Person *p = [Person personWithAge:30];
    stu.no = 888;
    
    return 0;
}
