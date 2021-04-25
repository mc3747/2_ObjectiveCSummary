//
//  main.m
//  自定义类实现copy
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

int main(int argc, const char * argv[]) {

    /*
     1.以后想让自定义的对象能够被copy只需要遵守NSCopying协议
     2.实现协议中的- (id)copyWithZone:(NSZone *)zone
     3.在- (id)copyWithZone:(NSZone *)zone方法中创建一个副本对象, 然后将当前对象的值赋值给副本对象即可
     */ 
    /*
    Person *p = [[Person alloc] init];
    p.age =  30;
    p.name = @"lnj";
    NSLog(@"%@", p);
//    Person *p2 = [p copy];
    Person *p2 = [p mutableCopy];
    
    NSLog(@"%@", p2);
    */
    
    Student *stu = [[Student alloc] init];
    stu.age = 30;
    stu.height = 1.75;
    stu.name = @"lnj";
   
    NSLog(@"stu = %@", stu);
    
    
    // 如果想让子类在copy的时候保留子类的属性, 那么必须重写copyWithZone方法, 在该方法中先调用父类创建副本设置值, 然后再设置子类特有的值
    Student *stu2 = [stu copy];
    //NSLog(@"stu2 = %@", stu2);
    
    return 0;
}
