//
//  Person.h
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wife.h"

@interface Person : NSObject

// 媳妇
// 注意: 记住一点, 类型限定是写在数据类型的右边的
@property (nonatomic, strong) Wife<WifeCondition> *wife;

- (void)show;
@end
