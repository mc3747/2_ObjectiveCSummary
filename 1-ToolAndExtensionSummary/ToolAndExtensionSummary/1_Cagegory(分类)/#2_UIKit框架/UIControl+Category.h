//
//  UIControl+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/15.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIControl (Category)

- (void)bk_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;


- (void)bk_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;


- (BOOL)bk_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
