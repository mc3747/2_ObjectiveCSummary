//
//  Person.h
//  day14
//
//  Created by 李南江 on 15/6/20.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property int age;

+ (void)test;
- (void)demo;

- (void)signalWithNumber:(NSString *)number;

- (void)sendMessageWithNumber:(NSString *)number andContetn:(NSString *)content;

// 调用传入对象的指定方法
- (void)makeObject:(id)obj andSel:(SEL)sel;
@end
