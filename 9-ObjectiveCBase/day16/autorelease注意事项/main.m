//
//  main.m
//  autorelease注意事项
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

    /*
    Person *p = [[Person alloc] init];
    @autoreleasepool {
//        Person *p = [[[Person alloc] init] autorelease];
//        [p run];
        
        // 2.在自动释放池中创建了对象, 一定要调用autorelease,才会将对象放入自动释放池中
//        Person *p = [[Person alloc] init];
//        [p run];
        
        // 3.只要在自动释放池中调用autorelease, 就会将对象放入自动释放池
        p = [p autorelease];
        [p run];
    }
    // 1.一定要在自动释放池中调用autorelease, 才会将对象放入自动释放池中
//    Person *p = [[[Person alloc] init] autorelease];
     */
    
    /*
    // 4.一个程序中可以创建N个自动释放池, 并且自动释放池还可以嵌套
    // 如果存在多个自动释放池的时候, 自动释放池是以 "栈" 的形式存储的
    // 栈的特点: 先进后出
    
    // 给一个对象方法一条autorelease消息, 永远会将对象放到栈顶的自动释放池
    @autoreleasepool { // 创建第一个释放池
        @autoreleasepool { // 创建第二个释放池
            @autoreleasepool { // 创建第三个释放池
                Person *p = [[[Person alloc] init] autorelease];
                [p run];
            } // 第三个释放池销毁
            
            Person *p = [[[Person alloc] init] autorelease];
            
        }// 第二个释放池销毁
    }// 第一个释放池销毁
    */
    
    @autoreleasepool {
        // 千万不要写多次autorelease
        // 一个allock, new对应一个autorelease
//        Person *p = [[[[Person alloc] init] autorelease] autorelease];
        
        // 如果写了autorelease就不要写release
        // 总之记住: 一个alloc/new对应一个autorelease或者release
        Person *p = [[[Person alloc] init] autorelease];
        [p release];
    }
    
    return 0;
}
