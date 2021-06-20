//
//  CustomPresentationController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/11/23.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "CustomPresentationController.h"

@implementation CustomPresentationController
//可以改变被模态的控制器视图的尺寸
- (CGRect)frameOfPresentedViewInContainerView
{

    /**  containerView是容纳presentedView的一个容器  */
    //return CGRectMake(0,50,self.containerView.frame.size.width,self.containerView.frame.size.height-100);

    return CGRectInset(self.containerView.bounds, 0, 50);
}

//过渡即将开始时的处理
- (void)presentationTransitionWillBegin
{
    self.presentedView.frame = self.containerView.frame;
    [self.containerView addSubview:self.presentedView];
}


- (void)presentationTransitionDidEnd:(BOOL)completed
{
    
}
- (void)dismissalTransitionWillBegin
{
    
}

//过渡消失时的处理
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    [self.presentedView removeFromSuperview];
}

@end
