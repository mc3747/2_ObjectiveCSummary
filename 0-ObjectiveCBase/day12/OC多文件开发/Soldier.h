//
//  Soldier.h
//  day12
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gun.h"

@interface Soldier : NSObject
{
@public
    NSString *_name;
    double _height;
    double _weight;
}
// 开火, 给士兵一把枪和一个弹夹
- (void)fire:(Gun *)gun clip:(Clip *)clip;
@end
