//
//  CommonMethod.m
//  NetworkSummary
//
//  Created by gjfax on 2019/4/29.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "CommonMethod.h"
#import <BAAlert.h>

@implementation CommonMethod
+ (void)showTextViewAlert:(NSString *)msg {
    GJWeakSelf;
    /*! 第一种封装使用示例 */
    [BAAlert ba_alertShowWithTitle:@"结果" message:msg image:nil buttonTitleArray:@[@"确定"] buttonTitleColorArray:@[[UIColor greenColor]] configuration:^(BAAlert *tempView) {
        GJStrongSelf;
        //        temp.bgColor       = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3];
        /*! 开启边缘触摸隐藏alertView */
        tempView.isTouchEdgeHide = YES;
        /*! 添加高斯模糊的样式 */
        tempView.blurEffectStyle = BAAlertBlurEffectStyleLight;
        /*! 开启动画 */
        tempView.showAnimate   = YES;
        //        /*! 进出场动画样式 默认为：1 */
        //        tempView.animatingStyle  = 1;

    } actionBlock:^(BAAlert *tempView, NSInteger index) {
        GJStrongSelf;
        [tempView ba_alertHidden];
       
    }];
}

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
