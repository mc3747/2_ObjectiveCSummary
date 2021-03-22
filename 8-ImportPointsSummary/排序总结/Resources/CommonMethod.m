//
//  CommonMethod.m
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod
#pragma mark -  顶部window
UIWindow *GJSMainWindow(void) {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}
#pragma mark - 顶部控制器
UIViewController *GJSTopMostViewController(void) {
    UIViewController *topViewController = GJSMainWindow().rootViewController;
    UIViewController *temp = nil;
    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    return topViewController;
}
//push控制器
void GJSPushViewController (UIViewController *vc,NSString *vcTitle,BOOL animated) {
    if (!vc || ![vc isKindOfClass:[UIViewController class]]) return;
    vc.title = vcTitle;
    [GJSTopMostViewController().navigationController pushViewController:vc animated:animated];
}

//push控制器名称
void GJSPushViewControllerWithName (NSString *vcName,NSString *vcTitle,BOOL animated){
    Class class = NSClassFromString(vcName);
       if (class) {
           UIViewController *vc = [class new];
          if (!vc || ![vc isKindOfClass:[UIViewController class]]) return;
           vc.title = vcTitle;
          [GJSTopMostViewController().navigationController pushViewController:vc animated:animated];
       };
}

@end
