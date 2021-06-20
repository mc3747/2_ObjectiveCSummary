//
//  ArrayDeduplicateManger.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2019/5/16.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "ArrayDeduplicateManger.h"

@implementation ArrayDeduplicateManger
//1,顺序不变
+(NSMutableArray *)method1:(NSArray *)originalArr{
    NSMutableArray *resultArrM = [NSMutableArray array];
    
    for (NSString *item in originalArr) {
        if (![resultArrM containsObject:item]) {
            [resultArrM addObject:item];
        }
    };
    return resultArrM;
}

//2，顺序随机：利用字典的key不重复
+(NSArray *)method2:(NSArray *)originalArr{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    for (NSNumber *n in originalArr) {
        [dictM setObject:n forKey:n];
    }
    return [dictM allValues];
}

//3，顺序随机：利用NSSet
+(NSArray *)method3:(NSArray *)originalArr{
    NSSet *set = [NSSet setWithArray:originalArr];
    return [set allObjects];
}

//4，顺序随机：valueForKeyPath
+(NSArray *)method4:(NSArray *)originalArr{
    
    return  [originalArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
}
@end
