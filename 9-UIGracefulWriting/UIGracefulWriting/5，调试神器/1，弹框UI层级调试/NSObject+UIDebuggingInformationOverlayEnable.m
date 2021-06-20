//
//  NSObject+UIDebuggingInformationOverlayEnable.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/16.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NSObject+UIDebuggingInformationOverlayEnable.h"
#import "FakeWindowClass.h"
#import <objc/runtime.h>

#if defined(DEBUG) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"


@implementation NSObject (UIDebuggingInformationOverlayEnable)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"UIDebuggingInformationOverlay");
        [FakeWindowClass swizzleSelector:@selector(init) newSelector:@selector(initSwizzled) forClass:cls isClassMethod:NO];
        [self swizzleSelector:@selector(prepareDebuggingOverlay) newSelector:@selector(prepareDebuggingOverlaySwizzled) forClass:cls isClassMethod:YES];
    });
}

+ (void)swizzleSelector:(SEL)originalSelector newSelector:(SEL)swizzledSelector forClass:(Class)class isClassMethod:(BOOL)isClassMethod {
    Method originalMethod = NULL;
    Method swizzledMethod = NULL;
    
    if (isClassMethod) {
        originalMethod = class_getClassMethod(class, originalSelector);
        swizzledMethod = class_getClassMethod([self class], swizzledSelector);
    } else {
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    }
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)prepareDebuggingOverlaySwizzled {
    id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlayInvokeGestureHandler");
    id handler = [overlayClass performSelector:NSSelectorFromString(@"mainHandler")];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:handler action:@selector(_handleActivationGesture:)];
    tapGesture.numberOfTouchesRequired = 2;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = handler;
    
    if(@available(iOS 13.0, *)){
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager;
        id _statusBar = nil;
          if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
              UIView *_localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
              if ([_localStatusBar respondsToSelector:@selector(statusBar)]) {
                  _statusBar = [_localStatusBar performSelector:@selector(statusBar)];
                      [_statusBar addGestureRecognizer:tapGesture];
              }
          }
    }else {
            UIView *statusBarWindow = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
            [statusBarWindow addGestureRecognizer:tapGesture];
    }

}

@end
#pragma clang diagnostic pop

#endif
