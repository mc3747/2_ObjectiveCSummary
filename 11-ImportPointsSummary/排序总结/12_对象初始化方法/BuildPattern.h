//
//  BuildPattern.h
//  排序总结
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildPattern : NSObject

@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) float height;
@property (nonatomic, assign) float weight;

- (instancetype)initWithAge:(NSString *)age height:(float)height;
- (instancetype)initWithAge:(NSString *)age height:(float)height weight:(float)weight;
@end
