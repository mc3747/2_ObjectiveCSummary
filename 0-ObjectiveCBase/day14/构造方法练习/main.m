//
//  main.m
//  构造方法练习
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Studnet.h"

int main(int argc, const char * argv[]) {
//    Person *p = [[Person alloc] init];
//    NSLog(@"%@", p);
//    
//    Person *p1 = [[Person alloc] init];
//    NSLog(@"%@", p1);
    
    Studnet *stu = [[Studnet alloc] init];
    NSLog(@"%@", stu);
    
    Studnet *stu1 = [[Studnet alloc] init];
    NSLog(@"%@", stu1);
    
    return 0;
}
