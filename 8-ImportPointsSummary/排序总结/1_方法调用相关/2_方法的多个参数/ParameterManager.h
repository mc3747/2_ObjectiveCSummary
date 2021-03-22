//
//  ToolManager.h
//  排序总结
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParameterClass.h"

typedef NS_ENUM(NSInteger , MethodType) {
    MethodType0 = 0,
    MethodType1,
    MethodType2,
    MethodType3,
};
@interface ParameterManager<ObjectType> : NSObject

//传模型
@property (nonatomic, strong) ObjectType parameter;
- (void)getParaWithType:(MethodType)method;

//传字典
+ (void)getParaWithDic:(NSDictionary *)dic type:(MethodType)method;

//传参数指针列表
+ (void)getType:(MethodType)mathod params:(NSString *)string, ...NS_REQUIRES_NIL_TERMINATION ;

@end
