//
//  main.m
//  字符串读写2
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

//    NSURL *url = [NSURL alloc] initWithString:<#(NSString *)#>
    
    /*
    // URL = 协议头://主机地址/路径
    NSString *path = @"file://192.168.13.10/Users/xiaomage/Desktop/课堂共享/day17/note/lnj.txt";
    NSLog(@"url编码前: %@", path);
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url编码后: %@", path);
    */
    
    /*
    // 如果访问本机的文件, 可以省略主机地址
    NSString *path = @"file:///Users/xiaomage/Desktop/课堂共享/day17/note/lnj.txt";
    NSLog(@"url编码前: %@", path);
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url编码后: %@", path);
    NSURL *url = [NSURL URLWithString:path];
    */
    
    // 上面的几种方法不可以的原因是因为URL中包含了中文, 如果URL中包含了中文, 必须对URL进行一次转码
    // fileURLWithPath创建出来的URL都是file:// 协议的
    /*
    NSURL *url = [NSURL fileURLWithPath:@"/Users/xiaomage/Desktop/课堂共享/day17/note/lnj.txt"];
    
    NSError *error = nil;
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) {
        
        NSLog(@"str = %@", str);
    }else{
        NSLog(@"error = %@", [error localizedDescription]);
    }
     */
    
    /*
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"str = %@", str);
     */
    
    
    NSString *str = @"abcdef";
    NSURL *url = [NSURL fileURLWithPath:@"/Users/xiaomage/Desktop/123.txt"];
    [str writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // 注意点: 如果重复写入, 后一次写入的会覆盖前一次写入的内容
    NSString *str2 = @"我们号";
    [str2 writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    return 0;
}
