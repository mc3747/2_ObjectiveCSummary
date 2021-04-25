//
//  main.m
//  Block基本使用
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>


void printRose(int num)
{
    for (int i = 0; i < num; ++i) {
        
        printf("  {@} \n");
        printf("   |  \n");
        printf("  \\|/ \n");
        printf("   | \n");
    }
}

int sum(int value1, int value2)
{
    return value1 + value2;
}
int main(int argc, const char * argv[]) {

    /*
    printf("  {@} \n");
    printf("   |  \n");
    printf("  \\|/ \n");
    printf("   |");
     */
    /*
//    printRose();
//    printRose();
    
    // void代表指向的函数没有返回值
    // ()代表指向的函数没有形参
    // (*roseP)代表roseP是一个指向函数的指针
//    void (*roseP) ();
//    roseP = printRose;
//    roseP();
    
    // 定义一个block变量,
    // block和函数一样,可以没有返回值,也没有形参
    // 也可以没有返回值有形参
    // 也可以有返回值没有形参
    // 也可以有返回值有形参
    // 所以, 在定义一个block变量的时候, 也需要告诉该变量将来保存的代码有没有返回值和形参
    
    // void代表block将来保存的代码没有返回值
    // ()代表block将来保存的代码没有形参
    // (^roseBlock) 代表reseBlock是一个block变量, 可以用于保存一段block代码
    void (^roseBlock) ();
    // 如果block没有参数, 那么^后面的()可以省略
    roseBlock = ^(){
        printf("  {@} \n");
        printf("   |  \n");
        printf("  \\|/ \n");
        printf("   | \n");
    };
    // 要想执行block保存的代码, 必须调用block才会执行
    roseBlock();
    roseBlock();
     */
    /*
//    printRose(10);
    
//    void (*roseP)(int);
//    roseP = printRose;
//    roseP(3);
    
    void (^roseBlock) (int);
    roseBlock = ^(int num){
        for (int i = 0; i < num; ++i) {
            
            printf("  {@} \n");
            printf("   |  \n");
            printf("  \\|/ \n");
            printf("   | \n");
        }
    
    };
    
    roseBlock(2);
     */
    
    /*
//    int (*sumP)(int, int);
//    sumP = sum;
//    NSLog(@"sum = %i", sumP(10 , 20));
    
    int (^sumBlock) (int, int);
    sumBlock =^(int value1, int value2){
        return value1 + value2;
    };
    NSLog(@"sum = %i", sumBlock(10, 40));
     */
    
    // block是一种数据类型
    int (^printBlock)(int) = ^int (int num){
        for (int i = 0; i < num; ++i) {
            printf("--------\n");
        }
        return 1;
    };
    printBlock(2);
    
//    int a = 10;
//    int b;
//    b = 20;
    return 0;
}
