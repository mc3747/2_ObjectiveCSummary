//
//  RankManager4.m
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "RankManager4.h"

@implementation RankManager4
+ (void)fourRankWithOCAscend:(NSMutableArray *)ascendingArr
{
    for (NSInteger i = 1; i < ascendingArr.count; i ++) {
        NSInteger temp = [ascendingArr[i] integerValue];
        for (NSInteger j = i - 1; j >= 0 && temp < [ascendingArr[j] integerValue]; j --) {
            ascendingArr[j + 1] = ascendingArr[j];
            ascendingArr[j] = [NSNumber numberWithInteger:temp];
        }
    }
    NSLog(@"插入升序排序结果：%@",ascendingArr);
}
@end
