//
//  BabyProtocol.h
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Baby;

@protocol BabyProtocol <NSObject>
// 喂婴儿吃东西
- (void)feedFood:(Baby *)baby;

// 哄婴儿睡觉
- (void)hongBaby:(Baby *)baby;
@end
