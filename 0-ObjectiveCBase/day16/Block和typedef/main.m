//
//  main.m
//  Block和typedef
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int sum(int value1, int value2)
{
    return value1 + value2;
}

int minus(int value1, int value2)
{
    return value1 - value2;
}

typedef int (*calculte)(int, int);

// 注意: 利用typedef给block起别名, 和指向函数的指针一样, block变量的名称就是别名
typedef int (^calculteBlock)(int , int);

int main(int argc, const char * argv[]) {

    /*
//    int (*sumP)(int, int);
//    sumP = sum;
    calculte sumP = sum;
    NSLog(@"sum = %i", sumP(20, 10));
    
    
//    int (*minusP)(int, int);
//    minusP = minus;
    calculte minusP = minus;
    NSLog(@"minus = %i", minusP(20, 10));
       */
    
//    int (^sumBlock)(int , int );
    calculteBlock sumBlock = ^(int value1, int value2){
        return value1 + value2;
    };
    NSLog(@"sum = %i", sumBlock(20, 10));
    
//    int (^minusBlock)(int , int);
    calculteBlock minusBlock = ^(int value1, int value2){
        return value1 - value2;
    };
    NSLog(@"minus = %i", minusBlock(20, 10));
    return 0;
}
