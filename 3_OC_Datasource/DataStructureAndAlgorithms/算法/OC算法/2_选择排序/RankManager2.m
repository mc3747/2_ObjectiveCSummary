//
//  RankManager2.m
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "RankManager2.h"

@implementation RankManager2

#pragma mark - 选择升序排序
+ (void)twoRankWithOCAscend:(NSMutableArray *)ascendingArr
{
    for (int i = 0; i < ascendingArr.count; i ++) {
        for (int j = i + 1; j < ascendingArr.count; j ++) {
            if ([ascendingArr[i] integerValue] > [ascendingArr[j] integerValue]) {
                int temp = [ascendingArr[i] intValue];
                ascendingArr[i] = ascendingArr[j];
                ascendingArr[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
    NSLog(@"选择升序排序后结果：%@", ascendingArr);
}

#pragma mark - 选择降序排序
+ (void)twoRankWithOCDesend:(NSMutableArray *)descendingArr
{
    for (int i = 0; i < descendingArr.count; i ++) {
        for (int j = i + 1; j < descendingArr.count; j ++) {
            if ([descendingArr[i] integerValue] < [descendingArr[j] integerValue]) {
                int temp = [descendingArr[i] intValue];
                descendingArr[i] = descendingArr[j];
                descendingArr[j] = [NSNumber numberWithInt:temp];
            }
        }
    }
    NSLog(@"选择降序排序后结果：%@", descendingArr);
}
@end
