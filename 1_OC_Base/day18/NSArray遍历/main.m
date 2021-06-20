//
//  main.m
//  NSArray遍历
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

//    NSArray *arr = @[@"lnj", @"lmj", @"jjj"];
    
    /*
    // 常规遍历
    for (int i = 0; i < arr.count; ++i) {
        NSLog(@"arr[%i] = %@", i, arr[i]);
    }
     */
    
    /*
    // 如果是OC数组可以使用OC中的增强for循环来遍历
    // 逐个取出arr中的元素, 将取出的元素赋值给obj
    // 注意: obj的类型可以根据数组中元素的类型来写, 不一定要写NSObject
//    for (NSObject *obj in arr) {
    for (NSString *obj in arr) {
        NSLog(@"obj = %@", obj);
    }
     */
    
    /*
    // 使用OC数组的迭代器来遍历
    // 每取出一个元素就会调用一次block
    // 每次调用block都会将当前取出的元素和元素对应的索引传递给我们
    // obj就是当前取出的元素, idx就是当前元素对应的索引
    // stop用于控制什么时候停止遍历
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx == 1) {
            *stop = YES;
        }
        NSLog(@"obj = %@, idx = %lu", obj, idx);
    }];
     */
    
    
    Person *p1 = [Person new];
    Person *p2 = [Person new];
    Person *p3 = [Person new];
    Person *p4 = [Person new];
    
    NSArray *arr = @[p1, p2, p3, p4];
    /*
    [arr enumerateObjectsUsingBlock:^(Person *obj, NSUInteger idx, BOOL *stop) {
        [obj say];
    }];
    */
    
    // 如果使用OC数组存储对象, 可以调用OC数组的方法让数组中所有的元素都执行指定的方法
    // 注意点: 如果数组中保存的不是相同类型的数据, 并且没有相同的方法, 那么会报错
//    [arr makeObjectsPerformSelector:@selector(say)];
    
    // withObject: 需要传递给调用方法的参数
    [arr makeObjectsPerformSelector:@selector(sayWithName:) withObject:@"lnj"];
    return 0;
}
