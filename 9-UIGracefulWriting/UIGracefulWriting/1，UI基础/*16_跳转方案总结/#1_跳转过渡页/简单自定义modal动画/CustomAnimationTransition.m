#import "CustomAnimationTransition.h"
#import "UIView+Extension.h"

const CGFloat duration = 0.5f;

@implementation CustomAnimationTransition


#pragma mark -<UIViewControllerAnimatedTransitioning>
//动画时间
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return duration;
}
//设置过渡动画（modal和dismiss的动画都需要在这里处理）
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // UITransitionContextToViewKey,
    // UITransitionContextFromViewKey.
    
    //出来的动画
    if (self.presented) {
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        //toView.y = -toView.height;  //设置动画从上往下进来
        toView.x = toView.width;      //设置动画从右往左进来
        
        //设置动画3D旋转
        //toView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
        
        [UIView animateWithDuration:duration animations:^{
            
            //toView.y = 0;
            toView.x = 0;
            
            //toView.layer.transform = CATransform3DIdentity;
            
        } completion:^(BOOL finished) {
            
            //动画完成后,视图上的事件才能处理
            [transitionContext completeTransition:YES];
        }];
    }
    //销毁的动画
    else
    {
        [UIView animateWithDuration:duration animations:^{
            
            UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
            
            //fromView.y = -fromView.height;
            fromView.x = fromView.width;     //从右往左出去
            
            //fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 1, 0);
            
        } completion:^(BOOL finished) {
            
            //动画完成后,视图上的事件才能处理
            [transitionContext completeTransition:YES];
        }];
    }
    
}
@end
