//
//  NoEmptyTools.h
//  数据排空
//
//  Created by yurong on 2017/8/23.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Dictionary,
    Array,
    String,
} objectType;
@interface NoEmptyTools : NSObject
+(id)noEmptyWithObject:(id)object;
@end
