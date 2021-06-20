//
//  main.m
//  自定义构造方法在继承中的表现
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Person.h"

int main(int argc, const char * argv[]) {

   //Student *stu = [[Student alloc] initWithAge:30 andName:@"lnj"];
    Student *stu = [[Student alloc] initWithAge:30 andName:@"lnj" andNo:888];
    NSLog(@"%@", stu);
    return 0;
}
