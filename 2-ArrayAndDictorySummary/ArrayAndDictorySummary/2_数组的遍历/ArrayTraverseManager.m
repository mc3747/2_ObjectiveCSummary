//
//  ArrayManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/1.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ArrayTraverseManager.h"
#import "TimeManager.h"

@implementation ArrayTraverseManager

/*数组遍历总结：
 1，数据量少，且需要获取下标的时候，用for循环
 2，使用For-in会比较快速, 推荐使用For-in遍历数组
 3，需要下标，中间停止循环：推荐使用 enumerateObjectsWithOptions方法
 4，需要下标，中间停止循环，且多线程并发处理大数据：推荐使用 enumerateObjectsWithOptions的并行方法
 */

#pragma mark -  1，for遍历
+ (void)traverse_1_WithArray:(NSArray *)array {
    
    NSString *startTime = [TimeManager getNowTimeStamp];
    for (int i = 0; i < array.count; ++i) {
        NSLog(@"for正向遍历：arr[%i] = %@", i, array[i]);
    };
    NSString *endTime = [TimeManager getNowTimeStamp];
    NSLog(@"for正向遍历时间：%@",[TimeManager getimeDifferenceStar:startTime End:endTime]);
    
    
    for (int i = (int)array.count - 1; i>0; i--) {
        NSLog(@"for反向遍历：arr[%i] = %@", i, array[i]);
    };
}

#pragma mark -  2，for in遍历
+ (void)traverse_2_WithArray:(NSArray *)array {
    
    NSString *startTime = [TimeManager getNowTimeStamp];
    for (NSObject *obj in array) {
    NSLog(@"for in正向遍历：obj = %@", obj);
    };
    NSString *endTime = [TimeManager getNowTimeStamp];
    NSLog(@"for正向遍历时间：%@",[TimeManager getimeDifferenceStar:startTime End:endTime]);
    
    for (id obj in [array reverseObjectEnumerator]) {
        NSLog(@"for in反向遍历：%@",obj);
    };
}

#pragma mark -  3，enumer遍历器遍历
+ (void)traverse_3_WithArray:(NSArray *)array {
    
     NSEnumerator *arrayEnumerator = [array objectEnumerator];
    NSString *obj;
    while ((obj = [arrayEnumerator nextObject]) != nil) {
        NSLog(@"enumer遍历器正向遍历%@",obj);
    }
    
    NSEnumerator *arrayEnumerator2 = [array reverseObjectEnumerator];
    NSString *obj2;
    while ((obj2 = [arrayEnumerator2 nextObject]) != nil) {
        NSLog(@"enumer遍历器反向遍历%@",obj2);
    }
}

#pragma mark -  4，enumer块正向遍历
+ (void)traverse_4_WithArray:(NSArray *)array {
    //obj就是当前取出的元素, idx就是当前元素对应的索引
    // stop用于控制什么时候停止遍历
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if (idx == 1) {
//            *stop = YES;
//        }
        NSLog(@"enumer块快速遍历：obj = %@, idx = %lu", obj, idx);
    }];
}

#pragma mark -  5，enumer块反向遍历
+ (void)traverse_5_WithArray:(NSArray *)array {
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"enumer块反向遍历：obj = %@, idx = %lu", obj, idx);
    }];
    
}

#pragma mark -  6，enumer块多线程并发遍历：乱序
+ (void)traverse_6_WithArray:(NSArray *)array {
    [array enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"enumer块多线程并发遍历：obj = %@, idx = %lu", obj, idx);
    }];
}

#pragma mark -  7，makeObjectsPerformSelector遍历
//该方法只用在UI视图本身具备的方法里边，不能写自定义方法（谨记 ，谨记）
+ (void)traverse_7_WithArray:(NSArray *)array {
    
//   [self.view.subviews makeObjectsPerformSelector:@selector(setBackgroundColor:) withObject:[UIColor greenColor]];
    
//    [array makeObjectsPerformSelector:@selector(doSomethings)];
    
}

- (void)doSomethings {
    NSLog(@"1");
}

#pragma mark -  8，dispatch_apply(Concurrent)遍历
//充分利用多线程来快速遍历，内部还是其他遍历方法，只不过利用了多线程，等同与enum块的多线程遍历方法
+ (void)traverse_8_WithArray:(NSArray *)array {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       /*
                       @param count] 遍历的次数
                       @param 0 在哪个队列执行闭包的代码
                       @param 0 执行的编号
                        */
            dispatch_apply([array count],
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
                for (NSInteger i = 0; i < array.count; i++) {
                    NSLog(@"%ld",(long)i);
                    }
                });
    });
    
}
#pragma mark -  9，kvc集合运算符
+ (void)traverse_9_WithArray:(NSArray *)array {
    
}


@end
