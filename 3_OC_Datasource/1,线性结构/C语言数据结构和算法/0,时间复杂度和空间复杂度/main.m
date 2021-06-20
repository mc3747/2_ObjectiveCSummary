//
//  main.m
//  0,时间复杂度和空间复杂度
//
//  Created by gjfax on 2018/3/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 二次循环
void test1(int N);
void test2(int N);
void test3(int N);
void test4(int N);
void test5(int N);
void test6(int N);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        test3(6);
    }
    return 0;
}
#pragma mark - 双层循环无关
void test1(int N) {
    int m = 1;
    for(int i=0;i<N;i++)
    {
        for(int j=0;j<N;j++)
        {
            //此处运行次数:N * N
            NSLog(@"执行了%d次",m);
            m ++;
        }
    }
}
#pragma mark - 双层循环有关
void test2(int N) {
    int m = 1;
    for(int i=0;i<N;i++)
    {
        for(int j=0;j<i;j++)
        {
            //此处运行次数:0 + 1 + 2 + ......+ N-1 = N(N-1)/2
            NSLog(@"执行了%d次",m);
            m ++;
        }
    }
}
#pragma mark - 双层循环有关
void test3(int N) {
    int m = 1;
    for(int i=0;i<N;i++)
    {
        for(int j=0;j<i-1;j++)
        {
            //此处运行次数:0 + 0 + 1 + 2 + ......+ N-2 = (N-1)N-2)/2
            NSLog(@"执行了%d次",m);
            m ++;
        }
    }
}

#pragma mark -双层循环参数有关
void test5(int N) {
    int m = 1;
    for(int i=0;i<N;i++)
    {
        for(int j=i;j<N;j++)
        {
            //此处运行次数:N+N-1+N-2+...+1=1+2+3+...+N=N(N+1)/2
            NSLog(@"执行了%d次",m);
            m ++;
        }
    }
}
#pragma mark -双层循环参数有关
void test6(int N) {
    int m = 1;
    for(int i=0;i<N;i++)
    {
        for(int j=i+1;j<N;j++)
        {
            //此处运行次数N-1+N-2+N-3+...+1=1+2+3+...+N-1=N(N-1)/2
            NSLog(@"执行了%d次",m);
        }
    }
}
