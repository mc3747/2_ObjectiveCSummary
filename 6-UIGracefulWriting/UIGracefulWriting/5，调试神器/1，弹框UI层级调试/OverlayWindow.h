//
//  FakeWindowClass.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OverlayWindow : UIWindow
- (UIGestureRecognizerState)state;
@end

NS_ASSUME_NONNULL_END
