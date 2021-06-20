//
//  ArraySortManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/4.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ArraySortManager.h"

@implementation ArraySortManager
#pragma mark -  方法1:C语言的8种排序方法

#pragma mark -  方法2:OC一般数组排序
+ (NSArray *)sort_1_WithArray:(NSArray *)array {
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//  写法1:
        return [obj1 compare:obj2]; //升序
//        return [obj2 compare:obj1]; //降序
  
//  写法2:
//        if ([obj1 integerValue] < [obj2 integerValue])
//        {
//            return NSOrderedDescending;
//        }
//        else
//        {
//            return NSOrderedAscending;
//        }
    }];
    
    
    return result;
}

#pragma mark -  方法3:OC对象数组排序
+ (NSArray *)sort_2_WithArray:(NSArray *)array {
    [array sortedArrayUsingSelector:@selector(compareWithStu:)];
    
    return array;
}

- (NSComparisonResult)compareWithStu:(NSArray *)array
{
    //按照升续排列
//    if (self.age > stu.age)
//    {
//        return NSOrderedDescending;
//    }
//    else if (self.age == stu.age)
//    {
//        return NSOrderedSame;
//    }
//    else
//    {
        return NSOrderedAscending;
//    }
}
#pragma mark -  方法4:OC对象数组排序
+ (NSArray *)sort_3_WithArray:(NSArray *)array {
    NSSortDescriptor *des1 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *des2 = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    [array sortedArrayUsingDescriptors:@[des1,des2]];
    return array;
}

@end
