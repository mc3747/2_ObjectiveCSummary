//
//  main.m
//  Copy内存管理
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    @autoreleasepool {
        
        /*
//        NSString *str1 = @"lnj";
        char *cstr = "this is a c string";
        NSString *str1 = [[NSString alloc] initWithUTF8String:cstr];
        NSLog(@"str = %lu", [str1 retainCount]); // 1
        // 不会产生新对象, 会对原有对象进行一次retain
        NSString *str2 = [str1 copy]; // 2
        NSLog(@"str = %lu", [str1 retainCount]);
        
        // 注意点: 如果是浅拷贝, 那么会对拷贝的对象进行一次retain, 那么我们就需要对拷贝出来的对象进行一次release
        [str2 release]; // 1
        [str1 release]; // 0
         */
        
        char *cstr = "this is a c string";
        NSString *str1 = [[NSString alloc] initWithUTF8String:cstr];
        NSLog(@"str1 = %lu", [str1 retainCount]); // 1
        
        // 会生成一个新的对象
        NSMutableString *str2 = [str1 mutableCopy];
        NSLog(@"%p %p", str1, str2);
        NSLog(@"str2 = %lu", [str2 retainCount]); // 1
        
        [str1 release];
        [str2 release];
        NSZone
        /*
         内存管理的原则, 有加就有减
         一次alloc/retain/copy 对应一次release
         */
        
    }
    return 0;
}
