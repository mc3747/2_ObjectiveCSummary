//
//  SportProtocol.h
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SportProtocol <NSObject>
// 1.协议只能声明方法, 不能声明属性
//{
//    int  _age;
//}

// 方法声明列表
// 注意: 如果没有使用任何关键字修饰协议中的方法, 那么该方法默认就是required的
@required
// 如果协议中的方法是@required的, 而遵守协议的类又没有实现该方法, 那么会报一个警告
- (void)playFootball;
@optional // 可选
// 如果协议中的方法是@optional的, 而遵守协议的类又没有实现该方法, 那么不会报警告
- (void)playBasketball;
- (void)playBaseball;
// 注意:@required和@optional仅仅使用程序员之间交流, 并不能严格的控制某一个遵守该协议的类必须要实现该方法, 因为即便不是实现也不会报错, 只会报一个警告
@end
