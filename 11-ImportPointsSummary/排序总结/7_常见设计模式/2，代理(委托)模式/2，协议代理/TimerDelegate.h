//
//  TimerDelegate.h
//  排序总结
//
//  Created by gjfax on 2018/9/10.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
//委托的协议定义
@protocol UpdateAlertDelegate <NSObject>
- (void)updateAlert;
@end

@interface TimerDelegate : NSObject
//委托变量定义
@property (nonatomic, weak) id<UpdateAlertDelegate> delegate;

- (void) startTheTimer;

@end
