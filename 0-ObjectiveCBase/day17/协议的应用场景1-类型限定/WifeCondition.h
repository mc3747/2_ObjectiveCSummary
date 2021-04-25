//
//  WifeCondition.h
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WifeCondition <NSObject>
// 会做饭
- (void)cooking;
// 会洗衣服
- (void)washing;
// 有一份好工作
- (void)job;
@end
