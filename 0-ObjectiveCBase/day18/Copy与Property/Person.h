//
//  Person.h
//  day18
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^myBlock)();

@interface Person : NSObject

// @property (nonatomic, retain) NSString *name;
@property (nonatomic, copy) NSString *name;

// 注意: 如果是block使用copy并不是拷贝, 而是转移
@property (nonatomic, copy) myBlock pBlock;
@end
