//
//  DicTraverseManager.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "DicTraverseManager.h"

@implementation DicTraverseManager
#pragma mark -  1,for循环遍历
+ (void)traverse_1_WithDic:(NSDictionary *)dic {
    for (int i = 0; i < dic.count; ++i) {
        // 获取字典中所有的key
        NSArray *keys = [dic allKeys];
        // 取出当前位置对应的key
        //        NSLog(@"%@", keys[i]);
        NSString *key = keys[i];
        NSString *value = dic[key];
        NSLog(@"key = %@, value = %@", key, value);
    }
}

#pragma mark -  2,for in快速遍历
+ (void)traverse_2_WithDic:(NSDictionary *)dic {
    for (NSString *key in dic) {
        //        NSLog(@"%@", key);
        NSString *value = dic[key];
        NSLog(@"key = %@, value = %@", key, value);
        
    }
}

#pragma mark -  3，遍历器遍历
+ (void)traverse_3_WithDic:(NSDictionary *)dic {
    NSEnumerator *dictEnumerator = [dic keyEnumerator];
    NSString *key;
    while ((key = [dictEnumerator nextObject]) != nil) {
        NSString *obj = dic[key];
        NSLog(@"%@",obj);
    }
}

#pragma mark -  4，block 块遍历
+ (void)traverse_4_WithDic:(NSDictionary *)dic {
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key = %@, value = %@", key, obj);
    }];
}
@end
