//
//  main.m
//  description
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

// https://github.com/tangqiaoboy/iOSBlogCN
int main(int argc, const char * argv[]) {
    
    Person *p = [Person new];
    [p setAge:30];
    [p setName:@"lnj"];
    [p setHeigth:1.75];
    [p setWeight:65];
    [p setTel:@"13554499311"];
    [p setEmail:@"lnj@520it.com"];
    
//    NSLog(@"age = %i, name = %@, height = %f, weight = %f, tel = %@, email = %@", [p age], [p name], [p height], [p weight], [p tel], [p email]);
    // %@是用来打印对象的, 其实%@的本质是用于打印字符串
    // 只要利用%@打印某个对象, 系统内部默认就会调用父类的description方法
    // 调用该方法, 该方法会返回一个字符串, 字符串的默认格式 <类的名称: 对象的地址>
    
    NSLog(@"person = %@", p);
    
    NSLog(@"%@---", p);
    // class注意c是小写, 只要给类发送class消息, 就会返回当前类的类对象
    // 1.获取Person对应的类对象
    Class c = [Person class];
    // 2.打印Person的类对象
    NSLog(@"当前对象对应的类 = %@", c);
    NSLog(@"当前对象的地址 = %p", p);
    return 0;
}
