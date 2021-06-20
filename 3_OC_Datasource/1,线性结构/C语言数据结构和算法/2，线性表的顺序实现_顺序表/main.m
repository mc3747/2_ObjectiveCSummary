//
//  main.m
//  2，线性表的顺序实现_顺序表
//
//  Created by gjfax on 2018/3/29.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>



#define MAXSIZE 100
#define OK 1
#define ERROR 0

typedef int Status;
typedef struct {
    int *elem;
    int length;
}Sqlist;

#pragma mark -  1，初始化
Sqlist* InitLIst(Sqlist *L) {
    Sqlist *list = NULL;
    list = (Sqlist *)malloc(sizeof(int));
    if (!list->elem) {
        return NULL;
    };
    return list;
}
#pragma mark -  2，取值

#pragma mark -  3，查找

#pragma mark -  4，插入

#pragma mark -  5，删除


int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
    }
    return 0;
}
