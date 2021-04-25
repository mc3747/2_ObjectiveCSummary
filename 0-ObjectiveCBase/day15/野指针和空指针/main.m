//
//  main.m
//  野指针和空指针
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

    @autoreleasepool {
        Person *p = [[Person alloc] init]; // 1
        
        // 只要一个对象被释放了, 我们就称这个对象为 "僵尸对象"
        // 当一个指针指向一个僵尸对象, 我们就称这个指针为野指针
        // 只要给一个野指针发送消息就会报错
        [p release]; // 1-1 = 0
        // *** -[Person release]: message sent to deallocated instance 0x1001146b0

        // 空指针  nil  0
        // 为了避免给野指针发送消息会报错, 一般情况下, 当一个对象被释放后我们会将这个对象的指针设置位空指针
        // 因为在OC中给空指针发送消息是不会报错的
        p = nil;
        
        [p release];
        [p release];
        [p release];
        [p release];
        [p release];
        [p release];
        [p release];
        
        
    }
    return 0;
}
