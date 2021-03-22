//
//  Transition.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/11/23.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "Transition.h"
#import "CustomPresentationController.h"
#import "CustomAnimationTransition.h"

@implementation Transition

+ (instancetype)sharedTransition {
    // 1.定义一个静态变量来保存你类的实例确保在你的类里面保持全局
    static Transition *_sharedInstance = nil;
    
    // 2.定义一个静态的dispatch_once_t变量来确保这个初始化存在一次
    static dispatch_once_t oncePredicate;
    
    // 3.用GCD来执行block初始化实例
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[Transition alloc] init];
        
        
    });
    
    return _sharedInstance;
}


#pragma mark - <UIViewControllerTransitioningDelegate>
//返回展示样式
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[CustomPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
}

//展示的动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    CustomAnimationTransition *animation = [[CustomAnimationTransition alloc]init];
    animation.presented = YES;
    return animation;
}

//关闭时的动画
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    CustomAnimationTransition *animation = [[CustomAnimationTransition alloc]init];
    animation.presented = NO;
    return animation;
}
@end
