//
//  main.m
//  Category基本使用
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+NJ.h"

/*
 方法:
 方法的声明:
 方法的实现:
 
 所以: 通过分类给某一个类扩充方法, 也分为声明和实现两个部分
 
 // 分类的声明
 @interface ClassName (CategoryName)
 NewMethod; //在类别中添加方法
 //不允许在类别中添加变量
 @end
 
 ClassName: 需要给哪个类扩充方法
 CategoryName: 分类的名称
 NewMethod: 扩种的方法
 
 // 分类的实现
 @implementation ClassName(CategoryName)
 
 NewMethod
 ... ...
 @end
 
 ClassName: 需要给哪个类扩充方法
 CategoryName: 分类的名称
 NewMethod: 扩种的方法
 
 */
int main(int argc, const char * argv[]) {
    Person *p = [[Person alloc] init];
    p.age = 30;
    [p say];
    
    [p playFootball];
    [p playBasketball];
    
    NSString;
    NSArray;
    return 0;
}
