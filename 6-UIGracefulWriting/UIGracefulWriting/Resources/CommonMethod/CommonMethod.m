//
//  CommonMethod.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/21.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "CommonMethod.h"


@implementation CommonMethod
#pragma mark -- 返回当前导航控制器的倒数几个VC：当前的count传0，前一个VC传1
+ (void)backToSpecificVC:(UINavigationController *)navi SpecificCount:(NSInteger)count fail:(void (^)(void))fail
{
    count++;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSInteger MaxCount = navi.viewControllers.count;
        if (MaxCount >= count && count > 0) {
            [navi popToViewController:navi.viewControllers[MaxCount - count]
                             animated:YES];
        }else {
            if (fail) {
                fail();
            }
        }
    }];
}

#pragma mark -  返回当前导航控制器的顺数几个VC，根控制器count传0，第一个传1
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi SpecificCount:(NSInteger)count fail:(void (^)(void))fail
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSInteger MaxCount = navi.viewControllers.count;
        if (MaxCount > count && count >= 0) {
            [navi popToViewController:navi.viewControllers[count]
                             animated:YES];
        }else {
            if (fail) {
                fail();
            }
        }
    }];
}

#pragma mark -  返回当前导航控制器中的特定名称的VC
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi SpecificName:(NSString *)name fail:(void (^)(void))fail
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSInteger index = 0;
        for (UIViewController *controller in navi.viewControllers) {
            if ([controller isKindOfClass:[NSClassFromString(name) class]]) {
                [navi popToViewController:controller animated:YES];
                break;
            }
            if (index == navi.viewControllers.count - 1) {
                
                if (fail) {
                    fail();
                }
            }
            index++;
        }
    }];
}

#pragma mark -  如果栈上有指定的控制器 返回root， 否则返回上一层（很特殊）
+ (void)backToRootVCWithStack:(UINavigationController *)navi SpecificName:(NSString *)name dismissVC:(BOOL)dissmiss
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSInteger index = 0;
        for (UIViewController *controller in navi.viewControllers) {
            if ([controller isKindOfClass:[NSClassFromString(name) class]]) {
                [navi popToRootViewControllerAnimated:YES];
                if (dissmiss) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeVC" object:nil];
                }
                
                break;
            }
            if (index == navi.viewControllers.count - 1) {
                
                [navi popViewControllerAnimated:YES];
            }
            index++;
        }
    }];
}
#pragma mark -  当前导航控制器是否有指定控制器
+ (BOOL)haveSpecialVCWithStack:(UINavigationController *)navi SpecificName:(NSString *)name;
{
    for (UIViewController *controller in navi.viewControllers) {
        if ([controller isKindOfClass:[NSClassFromString(name) class]]) {
            return YES;
        }
    }
    return NO;
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
#pragma mark -  任意地方push
void GJSPushViewController (UIViewController *vc,BOOL animated) {
    if (!vc || ![vc isKindOfClass:[UIViewController class]]) return;
    //    vc.hidesBottomBarWhenPushed = YES;
    [GJSTopMostViewController().navigationController pushViewController:vc animated:animated];
}

void GJSPushViewControllerWithName (NSString *vcName,BOOL animated){
    Class class = NSClassFromString(vcName);
       if (class) {
           UIViewController *vc = [class new];
          if (!vc || ![vc isKindOfClass:[UIViewController class]]) return;
          [GJSTopMostViewController().navigationController pushViewController:vc animated:animated];
       };
}

#pragma mark -  任意地方bottom push
void GJSBottomPushViewController (UIViewController *vc) {
    
    if (!vc || ![vc isKindOfClass:[UIViewController class]]) return;
    
        CATransition* transition = [CATransition animation];
        transition.duration = 0.3f;
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromTop;
        [GJSTopMostViewController().navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [GJSTopMostViewController().navigationController pushViewController:vc animated:NO];
    
    [GJSTopMostViewController().navigationController pushViewController:vc animated:YES];
}
#pragma mark -  任意地方present
void GJSPresentViewController (UIViewController *vc,BOOL animated) {
    if (!vc) return;
    // vc.hidesBottomBarWhenPushed = YES;
    [GJSTopMostViewController().navigationController presentViewController:vc animated:animated completion:^{
        
    }];
}

@end
