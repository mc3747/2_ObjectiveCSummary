 //
//  main.m
//  继承基本概念
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Iphone.h"  
#import "Android.h"

int main(int argc, const char * argv[]) {

    /*
     当前代码存在的问题: 重复代码太多
     
     可以利用继承来解决当前重复代码太多的问题
     只要A类继承了B类, 那么A类就拥有了B类的所有属性和方法(对象方法和类方法)
     */
    Iphone *p = [Iphone new];
    [p signalWithNumber:@"1355443322"];
    
    Android *a = [Android new];
    [a signalWithNumber:@"1868686886"];
    
    [Iphone brand];
    [Android brand];
    
    
    [p setCpu:100];
    NSLog(@"cpu = %i", [p cpu]);
    return 0;
}
