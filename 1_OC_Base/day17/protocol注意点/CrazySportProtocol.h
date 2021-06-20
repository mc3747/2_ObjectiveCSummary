//
//  CrazySportProtocol.h
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SportProtocol.h"

// 4.OC中的协议又可以遵守其它协议, 只要一个协议遵守了其它协议, 那么这个协议中就会自动包含其它协议的声明
@protocol CrazySportProtocol <SportProtocol>
// 跳楼
- (void)jumping;
@end
