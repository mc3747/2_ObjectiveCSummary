//
//  main.m
//  NSArray排序
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

    /*
    NSArray *arr = @[@10, @20, @5, @7, @15];
    NSLog(@"排序前: %@", arr);
    // 注意: 想使用compare方法对数组中的元素进行排序, 那么数组中的元素必须是Foundation框架中的对象, 也就是说不能是自定义对象
    NSArray *newArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"排序后: %@", newArr);
    */
    
    Person *p1 = [Person new];
    p1.age = 10;
    
    Person *p2 = [Person new];
    p2.age = 20;
    
    Person *p3 = [Person new];
    p3.age = 5;
    
    Person *p4 = [Person new];
    p4.age = 7;
    
    NSArray *arr = @[p1, p2, p3, p4];
    NSLog(@"排序前: %@", arr);
    // 按照人的年龄进行排序
    // 不能使用compare:方法对自定义对象进行排序
//    NSArray *newArr = [arr sortedArrayUsingSelector:@selector(compare:)];
    
    // 该方法默认会按照升序排序
    NSArray *newArr = [arr sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(Person *obj1, Person *obj2) {
        // 每次调用该block都会取出数组中的两个元素给我们
        // 二分
//        NSLog(@"obj1 = %@, obj2 = %@", obj1, obj2);
        return obj1.age > obj2.age;
//        return obj1.age < obj2.age;
        /*
        if (obj1.age > obj2.age) {
            // 5 4
            return NSOrderedDescending;
        }else if(obj1.age < obj2.age)
        {
            // 4 5
            return NSOrderedAscending;
        }else
        {
            return NSOrderedSame;
        }
         */
    }];
    NSLog(@"排序后: %@", newArr);
    return 0;
}
