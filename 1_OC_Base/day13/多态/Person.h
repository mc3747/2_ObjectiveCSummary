//
//  Person.h
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"
#import "Cat.h"

@interface Person : NSObject

/*
+ (void)food:(Dog *)dog;

+ (void)foodCat:(Cat *)cat;

// 骆驼
// 狗熊
// 豹子
// 大象
// 猴子
// 鸡
// 猪
// 草泥马
// ...
 */

+ (void)food:(Animal *)a;
@end
