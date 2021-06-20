//
//  ArrayDeduplicateManger.h
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2019/5/16.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArrayDeduplicateManger : NSObject
//1,顺序不变
+(NSMutableArray *)method1:(NSArray *)originalArr;

//2，顺序随机：利用字典的key不重复
+(NSArray *)method2:(NSArray *)originalArr;

//3，顺序随机：利用NSSet
+(NSArray *)method3:(NSArray *)originalArr;

//4，顺序随机：valueForKeyPath
+(NSArray *)method4:(NSArray *)originalArr;
@end

NS_ASSUME_NONNULL_END
