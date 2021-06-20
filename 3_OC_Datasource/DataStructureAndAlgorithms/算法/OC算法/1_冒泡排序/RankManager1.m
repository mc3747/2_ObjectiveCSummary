//
//  RankManage1.m
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "RankManager1.h"

@implementation RankManager1
void bubbleSort(int a[], int n){
    for(int i =0 ; i< n-1; ++i) {
        for(int j = 0; j < n-i-1; ++j) {
            if(a[j] > a[j+1])
            {
                int tmp = a[j] ; a[j] = a[j+1] ;  a[j+1] = tmp;
            }
        }
    }
}
void Bubble_1 (int r[], int n) {
    int i= n -1;  //初始时,最后位置保持不变
    while ( i> 0) {
        int pos= 0; //每趟开始时,无记录交换
        for (int j= 0; j< i; j++)
            if (r[j]> r[j+1]) {
                pos= j; //记录交换的位置
                int tmp = r[j]; r[j]=r[j+1];r[j+1]=tmp;
            }
        i= pos; //为下一趟排序作准备
    }
}

void Bubble_2 ( int r[], int n){
    int low = 0;
    int high= n -1; //设置变量的初始值
    int tmp,j;
    while (low < high) {
        for (j= low; j< high; ++j) //正向冒泡,找到最大者
            if (r[j]> r[j+1]) {
                tmp = r[j]; r[j]=r[j+1];r[j+1]=tmp;
            }
        --high;                    //修改high值, 前移一位
        for ( j=high; j>low; --j) //反向冒泡,找到最小者
            if (r[j]<r[j-1]) {
                tmp = r[j]; r[j]=r[j-1];r[j-1]=tmp;
            }
        ++low;                    //修改low值,后移一位
    }
}

+(void)oneRankWithCDesend1:(int *)a and:(int )n {
    
    bubbleSort(a, n);
    for(int i = 0; i < n; i++) {
        printf("%d\t", a[i]);
    };
    
}
+(void)oneRankWithCDesend2:(int *)a and:(int )n {
    
    Bubble_1(a, n);
    for(int i = 0; i < n; i++) {
        printf("%d\t", a[i]);
    };
    
}

+(void)oneRankWithCDesend3:(int *)a and:(int )n {
    
    Bubble_2(a, n);
    for(int i = 0; i < n; i++) {
        printf("%d\t", a[i]);
    };
    
}
+ (void)oneRankWithOCAscend:(NSMutableArray *)ascendingArr {
    for (int i = 0; i < ascendingArr.count; i++) {
        for (int j = 0; j < ascendingArr.count - 1 - i;j++) {
            if ([ascendingArr[j+1]intValue] < [ascendingArr[j] intValue]) {
                int temp = [ascendingArr[j] intValue];
                ascendingArr[j] = ascendingArr[j + 1];
                ascendingArr[j + 1] = [NSNumber numberWithInt:temp];
            }
        }
    }
    NSLog(@"冒泡升序排序后结果：%@", ascendingArr);
    
}

+ (void)oneRankWithOCDesend:(NSMutableArray *)descendingArr {
    for (int i = 0; i < descendingArr.count; i++) {
        for (int j = 0; j < descendingArr.count - 1 - i; j++) {
            if ([descendingArr[j] intValue] < [descendingArr[j + 1] intValue]) {
                int tmp = [descendingArr[j] intValue];
                descendingArr[j] = descendingArr[j + 1];
                descendingArr[j + 1] = [NSNumber numberWithInt:tmp];
            }
        }
    }
    NSLog(@"冒泡降序排序后结果：%@", descendingArr);
}
@end
