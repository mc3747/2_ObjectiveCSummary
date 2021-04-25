//
//  main.m
//  NSMutableString基本概念
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    
    /*
    NSString *str = @"lnj"; // 一开始str指向@"lnj"对应的内存
    str = @"lmj"; // 修改了str指针的指向, 让它指向@"lmj"对应的内存
    NSString *newStr = [str stringByReplacingOccurrencesOfString:@"l" withString:@"X"];
    NSLog(@"%@", newStr);
    */
    
    // 创建一个空的字符串
    NSMutableString *str = [NSMutableString string];
    NSLog(@"修改前: %@", str);
    [str appendString:@"lnj"];
    NSLog(@"修改后: %@", str);
    
    NSMutableString *strM = [[NSMutableString alloc] init];
//    strM = [NSMutableString alloc] initWithFormat:<#(NSString *), ...#>
//    strM = [NSMutableString stringWithFormat:<#(NSString *), ...#>]
    
    return 0;
}
