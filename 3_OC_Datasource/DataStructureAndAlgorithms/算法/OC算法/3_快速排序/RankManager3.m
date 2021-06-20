//
//  RankManager3.m
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "RankManager3.h"

@implementation RankManager3
#pragma mark - 快速升序排序
+ (void)threeRankWithOCAscend:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    if (left < right) {
        NSInteger temp = [self getMiddleIndex:arr leftIndex:left rightIndex:right];
        [RankManager3 threeRankWithOCAscend:arr leftIndex:left rightIndex:temp - 1];
        [RankManager3 threeRankWithOCAscend:arr leftIndex:temp + 1 rightIndex:right];
    }
    NSLog(@"快速升序排序结果：%@", arr);
}

+ (NSInteger)getMiddleIndex:(NSMutableArray *)arr leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    NSInteger tempValue = [arr[left] integerValue];
    while (left < right) {
        while (left < right && tempValue <= [arr[right] integerValue]) {
            right --;
        }
        if (left < right) {
            arr[left] = arr[right];
        }
        while (left < right && [arr[left] integerValue] <= tempValue) {
            left ++;
        }
        if (left < right) {
            arr[right] = arr[left];
        }
    }
    arr[left] = [NSNumber numberWithInteger:tempValue];
    return left;
}
@end
