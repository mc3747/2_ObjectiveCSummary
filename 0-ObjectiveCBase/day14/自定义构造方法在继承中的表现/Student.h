//
//  Student.h
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "Person.h"

@interface Student : Person

@property int no; // 学号

- (instancetype)initWithAge:(int)age andName:(NSString *)name andNo:(int)no;
@end
