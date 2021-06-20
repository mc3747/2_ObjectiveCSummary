//
//  TestModel.h
//  字典转模型
//
//  Created by gjfax on 2017/10/30.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TestDetailModel;
 /*易出错的场景：
  1，字典key在属性中找不到
  2，字典value类型与属性不一致:（统一返回用string接收）
  3，字典多层嵌套
  4，字典key中含有id
  */
@interface TestModel : NSObject
@property (nonatomic, copy)  NSString *name;
@property (nonatomic, copy)  NSString *age;
@property (nonatomic, copy)  NSArray<TestDetailModel *> *frame;

#pragma mark - 方法1:KVC：遍历字典中的key值，去模型类里面去查找有没有所对应的key
+ (instancetype)modelWithDict:(NSDictionary *)dict ;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

@interface TestDetailModel: NSObject
@property (nonatomic, copy) NSString *heighth;
@property (nonatomic, copy) NSString *width;
@end

