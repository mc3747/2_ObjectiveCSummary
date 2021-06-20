//
//  model.h
//  slimController
//
//  Created by zhifanYoung on 16/4/12.
//  Copyright © 2016年 zhifanYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

@property(copy, nonatomic) NSString  *title;

@property(copy, nonatomic) NSString *desc;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)modelWithDict:(NSDictionary *)dict;

+ (NSArray *)modelList;

@end
