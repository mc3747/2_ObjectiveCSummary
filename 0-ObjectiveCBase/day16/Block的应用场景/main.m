//
//  main.m
//  Block的应用场景
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 void goToWorkPrefix()
 {
 NSLog(@"起床");
 NSLog(@"穿衣服");
 NSLog(@"洗漱");
 NSLog(@"喝早茶");
 NSLog(@"驾车去上班");
 }
 
 void goToWorkSubfix()
 {
 NSLog(@"收拾东西");
 NSLog(@"驾车回家");
 NSLog(@"吃晚饭");
 NSLog(@"洗澡");
 NSLog(@"睡觉");
 }
 
 void goToWorkInday1()
 {
 goToWorkPrefix();
 
 NSLog(@"认识新同事");
 
 goToWorkSubfix();
 }
 
 void goToWorkInday2()
 {
 goToWorkPrefix();
 
 NSLog(@"熟悉公司代码");
 
 goToWorkSubfix();
 }
 
 
 void goToWorkInday3()
 {
 goToWorkPrefix();
 
 NSLog(@"开始编写代码");
 
 goToWorkSubfix();
 }
 
 void goToWorkInday4()
 {
 goToWorkPrefix();
 
 NSLog(@"应用程序上架");
 
 goToWorkSubfix();
 }
 */

// 当发现代码的前面和后面都是一样的时候, 这个时候就可以使用block
void goToWork(void (^workBlock)())
{
    NSLog(@"起床");
    NSLog(@"穿衣服");
    NSLog(@"洗漱");
    NSLog(@"喝早茶");
    NSLog(@"驾车去上班");
    
    // 不一样
    workBlock();
    
    NSLog(@"收拾东西");
    NSLog(@"驾车回家");
    NSLog(@"吃晚饭");
    NSLog(@"洗澡");
    NSLog(@"睡觉");
}

void goToWorkInDay1()
{
    goToWork(^{
        NSLog(@"认识新同事");
    });
}
void goToWorkInDay2()
{
    goToWork(^{
        NSLog(@"熟悉公司代码");
    });
}
void goToWorkInDay3()
{
    goToWork(^{
        NSLog(@"开始编写代码");
    });
}
void goToWorkInDay4()
{
    goToWork(^{
        NSLog(@"应用程序上架");
    });
}

/*
 找到需要读取的文件
 读取文件
 
 操作文件
 
 关闭文件
 */

int main(int argc, const char * argv[]) {

    goToWorkInDay2();
    return 0;
}
