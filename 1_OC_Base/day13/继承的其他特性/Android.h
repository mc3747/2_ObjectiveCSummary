//
//  Android.h
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Phone.h"

// 继承了某个类的类我们称之为子类
@interface Android : Phone

- (void)setCpu:(int)cpu;
- (int)cpu;
@end
