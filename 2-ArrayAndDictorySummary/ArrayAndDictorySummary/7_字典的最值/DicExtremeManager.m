//
//  DicExtremeManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "DicExtremeManager.h"

@implementation DicExtremeManager

+ (void)extreme_1_WithDic:(NSDictionary *)dic
                   maxKey:(NSString **)maxKey
                 maxValue:(NSString * __autoreleasing *)maxValue {
    
    if (dic.count > 0) {
        NSArray *valueArray = [dic allValues];
        float maxValueFloat = [[valueArray valueForKeyPath:@"@max.floatValue"] floatValue];
        
        [valueArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj floatValue] == maxValueFloat) {
                *maxValue = (NSString *)obj;
            }
        }];
        
        NSArray *keyArray = [dic allKeysForObject:*maxValue];
        *maxKey = (NSString *)[keyArray firstObject];
    }
}
@end
