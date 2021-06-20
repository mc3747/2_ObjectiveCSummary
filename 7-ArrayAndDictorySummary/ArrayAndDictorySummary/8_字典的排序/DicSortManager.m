//
//  DicSortManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "DicSortManager.h"

@implementation DicSortManager

#pragma mark -  1,指定方法
+ (NSDictionary *)sort_1_WithDic:(NSDictionary *)dic {
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2",
//                         @"value3", @"key3", @"value4", @"key4", nil];
    
    NSDictionary *newDic = [NSDictionary dictionaryWithDictionary:dic];
    // 先对 key 进行排序，再遍历数组
    id keys1 = [newDic keysSortedByValueUsingSelector:@selector(compare:)];
    
    for (id key in keys1) {
        NSLog(@"%@ = %@", key, dic[key]);
    }
    return newDic;
    
}

#pragma mark -  2,block排序
+ (NSDictionary *)sort_2_WithDic:(NSDictionary *)dic {
     NSDictionary *newDic = [NSDictionary dictionaryWithDictionary:dic];
    id keys2 = [newDic keysSortedByValueUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    for (id key in keys2) {
        NSLog(@"%@ = %@", key, dic[key]);
    }
    return newDic;
}

//+ (NSDictionary *)sort_3_WithDic:(NSDictionary *)dic {
//
//}
@end
