//
//  FakeWindowClass.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/15.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "FakeWindowClass.h"
#import "UIWindow+PrivateMethods.h"

@implementation FakeWindowClass

- (instancetype)initSwizzled {
    self = [super init];
    if (self) {
        [self _setWindowControlsStatusBarOrientation:NO];
    }
    return self;
}

@end
