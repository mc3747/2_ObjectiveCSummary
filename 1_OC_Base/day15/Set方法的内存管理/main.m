//
//  main.m
//  Set方法的内存管理
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Room.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        // 1.创建两个对象
        Person *p = [[Person alloc] init];
        Room *r = [[Room alloc] init];
        r.no = 888;
        
        // 2.将房间赋值给人
        // 人需要使用这间房, 只要人在房间就一定要在
        p.room = r; // [p setRoom:r]
        [r release];
        
        /*
        // 3.换房
        Room *r2 = [[Room alloc] init];
        r2.no = 444;
        // 有问题
        p.room = r2;
        [r2 release];
         */
        p.room = r;
        
        // 在这行代码之前, 人都没有被释放
        NSLog(@"-----");
        
        // 3,人都不在了, 房间也必须销毁
        [p release];
    }
    return 0;
}