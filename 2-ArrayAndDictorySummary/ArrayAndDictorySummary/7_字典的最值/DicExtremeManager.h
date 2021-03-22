//
//  DicExtremeManager.h
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DicExtremeManager : NSObject
+ (void)extreme_1_WithDic:(NSDictionary *)dic
                   maxKey:(NSString **)maxKey
                 maxValue:(NSString **)maxValue;
@end
