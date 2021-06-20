//
//  RankManager5.m
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "RankManager5.h"

@implementation RankManager5
#pragma mark - 希尔排序
+ (void)fiveRankWithOCAscend:(NSMutableArray *)ascendingArr
{
    NSMutableArray *buckt = [self createBucket];
    NSNumber *maxnumber = [self listMaxItem:ascendingArr];
    NSInteger maxLength = numberLength(maxnumber);
    for (int digit = 1; digit <= maxLength; digit++) {
        // 入桶
        for (NSNumber *item in ascendingArr) {
            NSInteger baseNumber = [self fetchBaseNumber:item digit:digit];
            NSMutableArray *mutArray = buckt[baseNumber];
            [mutArray addObject:item];
        }
        NSInteger index = 0;
        for (int i = 0; i < buckt.count; i++) {
            NSMutableArray *array = buckt[i];
            while (array.count != 0) {
                NSNumber *number = [array objectAtIndex:0];
                ascendingArr[index] = number;
                [array removeObjectAtIndex:0];
                index++;
            }
        }
    }
    NSLog(@"希尔升序排序结果：%@", ascendingArr);
}

+ (NSMutableArray *)createBucket {
    NSMutableArray *bucket = [NSMutableArray array];
    for (int index = 0; index < 10; index++) {
        NSMutableArray *array = [NSMutableArray array];
        [bucket addObject:array];
    }
    return bucket;
}

+ (NSNumber *)listMaxItem:(NSArray *)list {
    NSNumber *maxNumber = list[0];
    for (NSNumber *number in list) {
        if ([maxNumber integerValue] < [number integerValue]) {
            maxNumber = number;
        }
    }
    return maxNumber;
}

NSInteger numberLength(NSNumber *number) {
    NSString *string = [NSString stringWithFormat:@"%ld", (long)[number integerValue]];
    return string.length;
}

+ (NSInteger)fetchBaseNumber:(NSNumber *)number digit:(NSInteger)digit {
    if (digit > 0 && digit <= numberLength(number)) {
        NSMutableArray *numbersArray = [NSMutableArray array];
        NSString *string = [NSString stringWithFormat:@"%ld", [number integerValue]];
        for (int index = 0; index < numberLength(number); index++) {
            [numbersArray addObject:[string substringWithRange:NSMakeRange(index, 1)]];
        }
        NSString *str = numbersArray[numbersArray.count - digit];
        return [str integerValue];
    }
    return 0;
}
@end
