//
//  main.m
//  自定义构造方法
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

//    Person *p = [Person new];
//    Person *p = [[Person alloc] init];
//    p.age = 20;
//    Person *p = [[Person alloc] initWithAge:20];
//    Person *p = [[Person alloc] initWithName:@"lnj"];
    Person *p = [[Person alloc] initWithAge:20 andName:@"lnj"];
    NSLog(@"%@", p);
    
//    Person *p2 = [[Person alloc] init];
//    p2.age = 30;
//    Person *p2 = [[Person alloc] initWithAge:30];
//    Person *p2 = [[Person alloc] initWithName:@"lmj"];
    Person *p2 = [[Person alloc] initWithAge:30 andName:@"lmj"];
    NSLog(@"%@", p2);
    return 0;
}
