//
//  Car.h
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Wheel.h"
@class Wheel;

@interface Car : NSObject

@property (nonatomic, retain) Wheel *wheel;
@end
