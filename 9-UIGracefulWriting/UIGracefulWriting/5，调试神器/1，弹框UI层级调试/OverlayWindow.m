//
//  FakeWindowClass.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "OverlayWindow.h"


@implementation OverlayWindow

- (UIGestureRecognizerState)state {
    return UIGestureRecognizerStateEnded;
}
@end
