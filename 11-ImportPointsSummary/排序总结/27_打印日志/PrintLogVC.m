//
//  PrintLogVC.m
//  排序总结
//
//  Created by gjfax on 2019/10/24.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PrintLogVC.h"

//1️⃣，打印预编译-------------------打印日志-------------------------
//printf输出
#ifdef DEBUG
#define DPrint(...) printf("%s %s 第%d行: %s\n",__TIME__, __PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define DPrint(...)
#endif

//NSLog输出
//DEBUG  模式下打印日志：当前方法 + 行号 + 打印的内容
//__PRETTY_FUNCTION__：在 C++ 代码中包含更多的信息
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s➕%s➕[Line %d]➕"fmt),__FILE__ , __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

@implementation PrintLogVC
- (void)viewDidLoad{
    DLog(@"预编译宏");
// 2️⃣，打印方法
//  当前方法名
    NSLog(@"当前方法名：%@", NSStringFromSelector(_cmd));
    
//  当前类名
    NSLog(@"当前类名：%@", NSStringFromClass([self class]));
    
//  源码文件名
    NSLog(@"源码文件名：%@",  [[NSString stringWithUTF8String:__FILE__] lastPathComponent]);
//  当前堆栈
    NSLog(@"当前堆栈：%@", [NSThread callStackSymbols]);
}

// 3️⃣，打印中文

// 4️⃣，打印模型

@end
