//
//  main.m
//  Copy基本使用
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    /*
     // 会生成一个新的对象
    NSString *srcStr = @"lnj";
    // 只要是拷贝出来的对象, 拷贝出来的对象中的内容和以前对象中的内容一致
    // "一般"情况下拷贝会生成一个新的对象
    // 为什么会产生一个新的对象 1.因为拷贝要求修改原来的对象不能影响到拷贝出来得对象 \
                              修改拷贝出来的对象也不能影响到原来的对象, 所以需要生成一个新的对象 \
                            2.由于以前的对象是一个不可变的对象, 而通过mutableCopy拷贝出来的对象必须是一个可变的对象, 所以必须生成一个新的对象
    
    NSMutableString *copyStr = [srcStr mutableCopy];
    NSLog(@"srcStr = %@, copyStr = %@", srcStr, copyStr);
    NSLog(@"srcStr = %p, copyStr = %p", srcStr, copyStr);
     */
    
    /*
     //  会生成一个新的对象
    NSMutableString *srcStr = [NSMutableString stringWithFormat:@"lnj"];
    NSMutableString *copyStr = [srcStr mutableCopy];
    
    [srcStr appendString:@" cool"];
    NSLog(@"srcStr = %@, copyStr = %@", srcStr, copyStr);
    NSLog(@"srcStr = %p, copyStr = %p", srcStr, copyStr);
     */
    
    /*
     //  会生成一个新的对象
    NSMutableString *srcStr = [NSMutableString stringWithFormat:@"lnj"];
    NSString *copyStr = [srcStr copy];
    [srcStr appendString:@" cool"];
    NSLog(@"srcStr = %@, copyStr = %@", srcStr, copyStr);
    NSLog(@"srcStr = %p, copyStr = %p", srcStr, copyStr);
     */
    

    // 如果是通过不可变对象调用了copy方法, 那么不会生成一个新的对象
    // 原因: 因为原来的对象是不能修改的, 拷贝出来的对象也是不能修改的
    // 既然两个都不能修改, 所以永远不能影响到另外一个对象, 那么已经符合需求
    // 所以: OC为了对内存进行优化, 就不会生成一个新的对象
    NSString *srcStr = @"lnj";
    NSString *copyStr = [srcStr copy];
    NSLog(@"srcStr = %p, copyStr = %p", srcStr, copyStr);
    
    /*
     正是因为调用copy方法有时候会生成一个新的对象, 有时候不会生成一个新的对象
     所以: 如果没有生成新的对象, 我们称之为浅拷贝, 本质就是指针拷贝
          如果生成了新的对象, 我们称之为深拷贝, 本质就是会创建一个新的对象
     */
    return 0;
}
