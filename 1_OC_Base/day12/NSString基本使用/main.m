//
//  main.m
//  NSString基本使用
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <string.h>

@interface Iphone : NSObject
- (NSString *)loadMessage;
@end

@implementation Iphone

- (NSString *)loadMessage
{
//    return "老婆我们家我做主";
//    只需要在C语言字符串前面加上@符号, 系统就会自动将C语言字符串转换为OC字符串
    return @"老婆我们家我做主";
}

@end

int main(int argc, const char * argv[]) {
    
    /*
    // C语言中的字符串不是对象
    char *name1 = "lnj";
    char name2[] = "lmj";
    
    // OC中的字符串是一个对象
    // 正是因为OC中的字符串是一个对象, 所以它就具备了很多功能
    NSString *str = @"lk";
    
    Iphone *p = [Iphone new];
    // 注意: 输出C语言的字符串使用%s
    //      输出OC的字符串使用%@,  %@就专门用于输出对象类型的
//    NSLog(@"content = %s", [p loadMessage]);
    NSLog(@"content = %@", [p loadMessage]);
     */
    
    // 1.如何创建OC字符串
//    NSString *str = @"lnj";
    
//    printf("age = %i, height = %f\n", 30, 1.75);
//    NSString *str = [NSString stringWithFormat:@"age = %i, height = %f\n", 30, 1.75];
//    NSLog(@"str = %@", str);
    
    // 2.如何计算字符串的长度
//    char name[] = "lnj"; // l n j \0
    char name[] = "李";
    
    // 包含\0
    size_t size = sizeof(name);
    printf("size = %lu\n", size);
    
    // 不包含\0
    size_t length = strlen(name);
    printf("length = %lu\n", length);
    
    // 不包含\0的
    // 计算出来的是个数, 而不是占用的字节数
//    NSString *str = @"lnj";
    NSString *str = @"李南江";
    NSUInteger len = [str length];
    NSLog(@"len = %lu", len);
    return 0;
}
