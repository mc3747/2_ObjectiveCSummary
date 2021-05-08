//
//  Dog.h
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

@interface Dog : NSObject

//@property(nonatomic, retain)Person *owner;
@property(nonatomic, assign)Person *owner;
@end
