//
//  ArrayExtremeManager.h
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/4.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayExtremeManager : NSObject

//传指针，可以返回多个值，在调用地方
+ (void)extreme_1_WithArray:(NSArray *)array max:(float *)max
                                        maxIndex:(int *)maxIndex
                                             min:(float *)min
                                        minIndex:(int *)minIndex;

+ (void)extreme_2_WithArray:(NSArray *)array max:(float *)max
                                             min:(float *)min;

+ (void)extreme_3_WithArray:(NSArray *)array max:(float *)max
                                        maxIndex:(int *)maxIndex
                                             min:(float *)min
                                        minIndex:(int *)minIndex;

+ (void)extreme_4_WithArray:(NSArray *)array max:(float *)max
                                             min:(float *)min;
@end
