//
//  main.m
//  NSMutableDictionary
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {

    /*
    // 1.创建一个空的字典
    NSMutableDictionary *dictM = [NSMutableDictionary  dictionary];
    NSLog(@"%@", dictM);
    // 2.如何添加
    [dictM setObject:@"lnj" forKey:@"name"];
    NSLog(@"%@", dictM);
    // 会将传入字典中所有的键值对取出来添加到dictM中
    [dictM setValuesForKeysWithDictionary:@{@"age":@"30", @"height":@"1.75"}];
    NSLog(@"%@", dictM);
    // 3.如何获取
    NSLog(@"name = %@", dictM[@"name"]);
    
    // 4.如何删除
    [dictM removeObjectForKey:@"name"];
    NSLog(@"%@", dictM);
//    [dictM removeObjectsForKeys:@[@"age", @"height"]];
//     NSLog(@"%@", dictM);
    // 5.如何修改
    // 如果利用setObject方法给同名的key赋值, 那么新值会覆盖旧值
//    [dictM setObject:@"88" forKey:@"age"];
     dictM[@"age"] = @"88";
    NSLog(@"%@", dictM);
     */
    
    // 1.不能使用@{}来创建一个可变的字典
//    NSMutableDictionary *dictM = @{@"name":@"lnj"};
//    [dictM setObject:@"30" forKey:@"age"];
    
    
    // 2.如果是不可变数组, 那么key不能相同
    // 如果是不可变字典出现了同名的key, 那么后面的key对应的值不会被保存
    // 如果是在可变数组中, 后面的会覆盖前面的
    NSDictionary *dict = @{@"name":@"lmj", @"name":@"lnj"};
    NSLog(@"dict = %@", dict);
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithObjects:@[@"lmj", @"lnj"] forKeys:@[@"name", @"name"]];
    NSLog(@"dict = %@", dictM);
    
    return 0;
}
