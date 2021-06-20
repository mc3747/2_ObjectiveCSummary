//
//  RankManage1.h
//  DataStructureAndAlgorithms
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankManager1 : NSObject
/*1,冒泡排序 */

+(void)oneRankWithCDesend1:(int *)a and:(int )n;
+(void)oneRankWithCDesend2:(int *)a and:(int )n;
+(void)oneRankWithCDesend3:(int *)a and:(int )n;

+ (void)oneRankWithOCAscend:(NSMutableArray *)array;
+ (void)oneRankWithOCDesend:(NSMutableArray *)array;
@end
