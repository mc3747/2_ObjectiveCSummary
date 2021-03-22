//
//  THDepModelTool.h
//  TaiHealthy
//
//  Created by lujh on 2017/9/5.
//  Copyright © 2017年 taiKang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THDepModelTool : NSObject

// 对应的传入的属性名的 value
@property (nonatomic, copy) NSString *valueStr;
// 模型
@property (nonatomic, strong) NSObject *model;
// 大写英文
@property (nonatomic, copy) NSString *bigString;
// 首字母
@property (nonatomic, copy) NSString *firstStr;


+ (NSMutableDictionary *)sortWithDataArray:(NSArray *)dataArray andPropertyName:(NSString *)name;


/**
 *  传入首字母进行排序#号在后
 *
 *  @param array 排序前
 *
 *  @return 排序后首字母数组
 */
+ (NSMutableArray *)sortFirstStrWithArray:(NSArray *)array;


+ (NSArray *)getAllValuesWithFromDict:(NSDictionary *)dict;

@end
