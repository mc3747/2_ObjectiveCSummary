//
//  RankManager8.m
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "RankManager8.h"

@implementation RankManager8
#pragma mark - 堆排序
+ (void)eightRankWithOCAscend:(NSMutableArray *)ascendingArr
{
    NSInteger endIndex = ascendingArr.count - 1;
    ascendingArr = [self heapCreate:ascendingArr];
    while (endIndex >= 0) {
        //        NSLog(@"将list[0]:\%@与list[\(endIndex)]:\%@交换", ascendingArr[0], ascendingArr[endIndex]);
        NSNumber *temp = ascendingArr[0];
        ascendingArr[0] = ascendingArr[endIndex];
        ascendingArr[endIndex] = temp;
        endIndex -= 1;
        ascendingArr = [self heapAdjast:ascendingArr withStartIndex:0 withEndIndex:endIndex + 1];
    }
    NSLog(@"堆排序结果：%@", ascendingArr);
}

+ (NSMutableArray *)heapCreate:(NSMutableArray *)array
{
    NSInteger i = array.count;
    while (i > 0) {
        array = [self heapAdjast:array withStartIndex:i - 1 withEndIndex:array.count];
        i -= 1;
    }
    return array;
}

+ (NSMutableArray *)heapAdjast:(NSMutableArray *)items withStartIndex:(NSInteger)startIndex withEndIndex:(NSInteger)endIndex
{
    NSNumber *temp = items[startIndex];
    NSInteger fatherIndex = startIndex + 1;
    NSInteger maxChildIndex = 2 * fatherIndex;
    while (maxChildIndex <= endIndex) {
        if (maxChildIndex < endIndex && [items[maxChildIndex - 1] floatValue] < [items[maxChildIndex] floatValue]) {
            maxChildIndex++;
        }
        if ([temp floatValue] < [items[maxChildIndex - 1] floatValue]) {
            items[fatherIndex - 1] = items[maxChildIndex - 1];
        } else {
            break;
        }
        fatherIndex = maxChildIndex;
        maxChildIndex = fatherIndex * 2;
    }
    items[fatherIndex - 1] = temp;
    return items;
}
@end
