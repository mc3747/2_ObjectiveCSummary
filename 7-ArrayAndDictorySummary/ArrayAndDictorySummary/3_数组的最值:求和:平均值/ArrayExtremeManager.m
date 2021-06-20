//
//  ArrayExtremeManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/4.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ArrayExtremeManager.h"

@implementation ArrayExtremeManager
#pragma mark -  1，for循环：可以获取下标
+ (void)extreme_1_WithArray:(NSArray *)array max:(float *)max
                                        maxIndex:(int *)maxIndex
                                             min:(float *)min
                                        minIndex:(int *)minIndex {

    
    for (int i = 0; i<array.count; i++) {
        
        //取最小值和最小值的对应下标
        int b = [array[i] floatValue];
        if (b < *min) {
            *minIndex = i;
            *min = b;
        };
        
        //取最大值和最大值的对应下标
        int a = [array[i] floatValue];
        if (a >= *max) {
            *maxIndex = i;
            *max = a;
        };
        
 
        
//
//        // 取平均数和总和
//        int c = [array[i] intValue];
//        all += c;
//        mid = all/array.count;
        
    }
}
#pragma mark -  2，for快速循环：不用获取下标
+ (void)extreme_2_WithArray:(NSArray *)array max:(float *)max
                                             min:(float *)min {
    
    //假设的最大值
    *max = [array[0] floatValue];
    
    //假设的最小值
    *min = [array[0] floatValue];
    
    for (NSNumber *num in array) {
        
        //判断最大值
        if(*max < num.intValue){
            
            *max = num.intValue;
            
        }
        //判断最小值
        if(*min > num.intValue){
            *min = num.intValue;
        }
    };
    
}
#pragma mark -  3,block块遍历
+ (void)extreme_3_WithArray:(NSArray *)array max:(float *)max
                                        maxIndex:(int *)maxIndex
                                             min:(float *)min
                                        minIndex:(int *)minIndex {
    
    [array enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger idx, BOOL *stop) {
        float x = num.floatValue;
        
        if (x <= *min) {
            *min = x;
            *maxIndex = (int)idx;
            
        } else if (x >= *max) {
            *max = x;
            *minIndex = (int)idx;
        };
        
    }];
    
   
}

#pragma mark -  4，kVC的方法
+ (void)extreme_4_WithArray:(NSArray *)array max:(float *)max min:(float *)min{
  
    *max = [[array valueForKeyPath:@"@max.floatValue"] floatValue];
    *min = [[array valueForKeyPath:@"@min.floatValue"] floatValue];
    
    /*
    @”@max.floatValue”（获取最大值），
    @”@min.floatValue”（获取最小值），
    @"@sum.floatValue"] floatValue"(获取求和);
    @”@avg.floatValue” (获取平均值)，
    @”@count.floatValue”(获取数组大小)
    */
}

#pragma mark -  5，OC封装的排序方法
+ (void)extreme_5_WithArray:(NSArray *)array max:(float *)max min:(float *)min{
//第二种方法是IOS已经给我们封装好的方法，那就是使用NSArray的sortedArrayUsingComparator方法：

NSArray *arraya = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    if ([obj1 floatValue] > [obj2 floatValue] ) {
        return NSOrderedDescending;
    }
    if ([obj1 floatValue] < [obj2 floatValue] ) {
        return NSOrderedAscending;
    }
    
    return NSOrderedSame;
}];
    *max = [[arraya firstObject] floatValue];
    *min = [[arraya lastObject] floatValue];
    
}
#pragma mark -  求和 / 平均值 均可以采用求最大值和最小值的4种方法，类推

@end
