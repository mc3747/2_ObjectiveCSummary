//
//  ReceiveValueVC.h
//  排序总结
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
// 声明代理
@protocol PassValueDelegate <NSObject>

// 代理方法
- (void)passValue:(NSString *)string;

@end

typedef void(^PassValueBlock)(NSString *string);

@interface ReceiveValueVC : UIViewController

// 1， 属性传值
@property (nonatomic, copy) NSString *string;

// 2, 代理传值
@property (nonatomic, weak) id<PassValueDelegate> delegate;

// 3，block传值
@property (nonatomic, copy)PassValueBlock block;

// 4，通知传值

// 5，KVO回传

@end
