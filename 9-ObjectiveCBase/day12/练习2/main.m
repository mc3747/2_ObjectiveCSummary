//
//  main.m
//  练习2
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Person : NSObject
{
@public
    int age;
    double height;
}
- (void)print;
@end

//  int newAge = 10, double newHeight = 1.5
void test1(int newAge, double newHeight);
void test2(Person *newP);
void test3(Person *newP);
void test4(Person *newP);

int main()
{
    Person *p = [Person new];
    p->age = 10;
    p->height = 1.5f;
    
    test1(p->age, p->height); // 10, 1.5
    [p print]; // 10, 1.5
    
    test2(p); // 指针, 地址
    [p print]; // 20, 1.7
    
    test3(p); // 指针, 地址
    [p print]; // 20, 1.7
    
    test4(p); // 指针, 地址
    [p print]; // 60, 1.9
    
    return 0;
}
@implementation Person
- (void)print
{
    NSLog(@"年龄=%d，身高=%f", age, height); // 10, 1.5
}
@end

void test1(int newAge, double newHeight)
{
    newAge = 30;
    newHeight = 1.6;
}

//   Person *newP = p;
void test2(Person *newP)
{
    newP->age = 20;
    newP->height = 1.7;
}

//   Person *newP = p;
void test3(Person *newP)
{
    Person *p2 = [Person new];
    p2->age = 40;
    p2->height = 1.8;
    newP = p2;
    
    newP->age = 30;
}

void test4(Person *newP)
{
    Person *p2 = newP;
    p2->age = 50;
    p2->height = 1.9;
    newP->age = 60;
}
