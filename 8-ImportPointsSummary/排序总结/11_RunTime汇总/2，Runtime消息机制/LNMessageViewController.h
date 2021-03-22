//
//  LNMessageViewController.h
//  🔍白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【🔍Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import <UIKit/UIKit.h>

@interface LNMessageViewController : UIViewController

/**
 1.
 类方法本质:类对象调用[NSObject class]
 id:谁发送消息
 SEL:发送什么消息
 ((NSObject *(*)(id, SEL))(void *)objc_msgSend)([NSObject class], @selector(alloc));
 xcode6之前,苹果运行使用objc_msgSend.而且有参数提示
 xcode6苹果不推荐我们使用runtime

 2.
 开发中使用场景:
 需要用到runtime,消息机制
 1.装逼
 2.不得不用runtime消息机制,可以帮我 调用私有方法.

 */


@end
