//
//  main.m
//  字符串与路径
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    NSString *str = @"User/lnj/Desktop/lnj.txt.jpg";
    // 1.判断是否是绝对路径
    /*
    // 其实本质就是判断字符串是否以/开头
    if([str isAbsolutePath])
    {
        NSLog(@"是绝对路径");
    }else{
        NSLog(@"不是绝对路径");
    }
     */
    
    // 2.获取文件路径中的最后一个目录
    // 本质就是获取路径中最后一个/后面的内容
    /*
    NSString *newStr = [str lastPathComponent];
    NSLog(@"%@", newStr);
     */
    // 3.删除文件路径中的最后一个目录
    /*
    // 本质就是删除最后一个/后面的内容, 包括/也会被删除
    NSString *newStr = [str stringByDeletingLastPathComponent];
    NSLog(@"%@", newStr);
     */
    // 4.给文件路径添加一个目录
    /*
     // 本质就是在字符串的末尾加上一个/ 和指定的内容
     // 注意: 如果路径后面已经有了/, 那么就不会添加了
     //      如果路径后面有多个/, 那么会自动删除多余的/, 只保留一个
     NSString *newStr = [str stringByAppendingPathComponent:@"xmg"];
     NSLog(@"%@", newStr);
     */
    
    // 5.获取路径中文件的扩展名
    /*
    // 本质就是从字符串的末尾开始查找., 截取第一个.后面的内容
    NSString *newStr = [str pathExtension];
    NSLog(@"%@", newStr);
     */
    // 6.删除路径中文件的扩展名
    /*
    // 本质就是从字符串的末尾开始查找.,删除第一个.和.后面的内容
    NSString *newStr = [str stringByDeletingPathExtension];
    NSLog(@"%@", newStr);
     */
    // 7.给文件路径添加一个扩展名
    // 本质就是在字符串的末尾加上一个.和指定的内容
    NSString *newStr = [str stringByAppendingPathExtension:@"jpg"];
    NSLog(@"%@", newStr);
    return 0;
}
