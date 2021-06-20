//
//  UIViewAnimationVC.m
//  WHLatticeDemo
//
//  Created by gjfax on 2018/11/6.
//  Copyright © 2018 remember17. All rights reserved.
//

#import "UIViewAnimationVC.h"

@interface UIViewAnimationVC ()
@property (nonatomic, assign) NSInteger count;
@property (weak, nonatomic) IBOutlet UIButton *demoBtn1;
@property (weak, nonatomic) IBOutlet UIButton *demoBtn2;
@property (weak, nonatomic) IBOutlet UIButton *demoBtn3;

@end

@implementation UIViewAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark -  view的普通动画
/*
 // 第一个参数: 动画标识
 // 第二个参数: 附加参数,在设置代理情况下，此参数将发送到setAnimationWillStartSelector和setAnimationDidStopSelector所指定的方法，大部分情况，设置为nil.
 [UIView beginAnimations:(nullable NSString *) context:(nullable void *)];
 结束动画语句：
 
 [UIView commitAnimations];
 动画参数的属性设置:
 
 //动画持续时间
 [UIView setAnimationDuration:(NSTimeInterval)];
 //动画的代理对象
 [UIView setAnimationDelegate:(nullable id)];
 //设置动画将开始时代理对象执行的SEL
 [UIView setAnimationWillStartSelector:(nullable SEL)];
 //设置动画延迟执行的时间
 [UIView setAnimationDelay:(NSTimeInterval)];
 //设置动画的重复次数
 [UIView setAnimationRepeatCount:(float)];
 //设置动画的曲线
 UIViewAnimationCurve的枚举值：
 UIViewAnimationCurveEaseInOut,         // 慢进慢出（默认值）
 UIViewAnimationCurveEaseIn,            // 慢进
 UIViewAnimationCurveEaseOut,           // 慢出
 UIViewAnimationCurveLinear             // 匀速

[UIView setAnimationCurve:(UIViewAnimationCurve)];
 
//设置是否从当前状态开始播放动画
//假设上一个动画正在播放，且尚未播放完毕，我们将要进行一个新的动画：
 当为YES时：动画将从上一个动画所在的状态开始播放
 当为NO时：动画将从上一个动画所指定的最终状态开始播放（此时上一个动画马上结束）
[UIView setAnimationBeginsFromCurrentState:YES];
 
//设置动画是否继续执行相反的动画
[UIView setAnimationRepeatAutoreverses:(BOOL)];
 
//是否禁用动画效果（对象属性依然会被改变，只是没有动画效果）
[UIView setAnimationsEnabled:(BOOL)];
 
//设置视图的过渡效果
第一个参数：UIViewAnimationTransition的枚举值如下
 UIViewAnimationTransitionNone,              //不使用动画
 UIViewAnimationTransitionFlipFromLeft,      //从左向右旋转翻页
 UIViewAnimationTransitionFlipFromRight,     //从右向左旋转翻页
 UIViewAnimationTransitionCurlUp,            //从下往上卷曲翻页
 UIViewAnimationTransitionCurlDown,          //从上往下卷曲翻页
 第二个参数：需要过渡效果的View
 第三个参数：是否使用视图缓存，YES：视图在开始和结束时渲染一次；NO：视图在每一帧都渲染
[UIView setAnimationTransition:(UIViewAnimationTransition) forView:(nonnull UIView *) cache:(BOOL)];


 */
- (IBAction)normalViewAnimateAction1:(id)sender {
    [UIView beginAnimations:@"testAnimation" context:nil];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationDelegate:self];
    //设置动画将开始时代理对象执行的SEL
    [UIView setAnimationWillStartSelector:@selector(animationDoing)];
    
    //设置动画延迟执行的时间
    [UIView setAnimationDelay:0];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    //设置动画是否继续执行相反的动画
    [UIView setAnimationRepeatAutoreverses:YES];
    UIButton *btn = (UIButton *)sender;
    btn.transform = CGAffineTransformMakeScale(1.5, 1.5);
    btn.transform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView commitAnimations];
}

- (IBAction)normalViewAnimateAction2:(id)sender {
        UIButton *btn = (UIButton *)sender;
    
    // 转成动画 (flip)
    [UIView beginAnimations:@"imageViewTranslation" context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAnimation:)];
    [UIView setAnimationDidStopSelector:@selector(stopAnimation:)];
    [UIView setAnimationRepeatCount:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    
  
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:btn cache:YES];
  
    [UIView commitAnimations];
    
}
- (void)startAnimation:(id)sender {
    if (++_count % 2 == 0) {
        [_demoBtn2 setBackgroundImage:[UIImage imageNamed:@"CAEAGLLayer"] forState:UIControlStateNormal];
        
    }else{
        [_demoBtn2 setBackgroundImage:[UIImage imageNamed:@"CATransformLayer"] forState:UIControlStateNormal];
        
    };
}
- (void)stopAnimation:(id)sender {
    
}
- (IBAction)normalViewAnimateAction3:(id)sender {
    //1 准备动画
    //参数1: 动画的作用, 任意字符串，用来区分多个动画, 参数二: 传递参数用 nil:OC中使用
    [UIView beginAnimations:@"changeSizeAndColor" context:nil];
    //在准备动画的时候可以设置动画的属性
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAnimation)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//动画的曲线
    [UIView setAnimationRepeatCount:2];
    [UIView setAnimationRepeatAutoreverses:YES];//动画往返执行, 必须设置动画的重复次数
    UIButton *btn = (UIButton *)sender;
    //2 修改view的属性, 可以同时修改多个属性 注意:不是所有的属性都可以修改的(只有frame, center, bounds, backgroundColor, alpha, transform 可以修改)
    btn.frame = CGRectMake(110, 100, 100, 100);
    btn.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:0.5];
    
    //3 提交并执行动画
    [UIView commitAnimations];
}


#pragma mark -  view的block动画

#pragma mark -  时间
/*
 [UIView animateWithDuration:(NSTimeInterval)  //动画持续时间
 animations:^{
 //执行的动画
 }];
*/

#pragma mark -  时间 + finish
/*
 [UIView animateWithDuration:(NSTimeInterval)  //动画持续时间
 animations:^{
 //执行的动画
 }                completion:^(BOOL finished) {
 //动画执行提交后的操作
 }];
 
 */

#pragma mark -  时间 + 延时 + 过渡效果
/*
 [UIView animateWithDuration:(NSTimeInterval) //动画持续时间
 delay:(NSTimeInterval) //动画延迟执行的时间
 options:(UIViewAnimationOptions) //动画的过渡效果
 animations:^{
 //执行的动画
 }                completion:^(BOOL finished) {
 //动画执行提交后的操作
 }];
 
 UIViewAnimationOptionLayoutSubviews            //进行动画时布局子控件
 UIViewAnimationOptionAllowUserInteraction      //进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
 UIViewAnimationOptionRepeat                    //无限重复执行动画
 UIViewAnimationOptionAutoreverse               //执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedCurve    //忽略嵌套动画的曲线设置
 UIViewAnimationOptionAllowAnimatedContent      //转场：进行动画时重绘视图
 UIViewAnimationOptionShowHideTransitionViews   //转场：移除（添加和移除图层的）动画效果
 UIViewAnimationOptionOverrideInheritedOptions  //不继承父动画设置
 
 UIViewAnimationOptionCurveEaseInOut            //时间曲线，慢进慢出（默认值）
 UIViewAnimationOptionCurveEaseIn               //时间曲线，慢进
 UIViewAnimationOptionCurveEaseOut              //时间曲线，慢出
 UIViewAnimationOptionCurveLinear               //时间曲线，匀速
 
 UIViewAnimationOptionTransitionNone            //转场，不使用动画
 UIViewAnimationOptionTransitionFlipFromLeft    //转场，从左向右旋转翻页
 UIViewAnimationOptionTransitionFlipFromRight   //转场，从右向左旋转翻页
 UIViewAnimationOptionTransitionCurlUp          //转场，下往上卷曲翻页
 UIViewAnimationOptionTransitionCurlDown        //转场，从上往下卷曲翻页
 UIViewAnimationOptionTransitionCrossDissolve   //转场，交叉消失和出现
 UIViewAnimationOptionTransitionFlipFromTop     //转场，从上向下旋转翻页
 UIViewAnimationOptionTransitionFlipFromBottom  //转场，从下向上旋转翻页

 */

#pragma mark -  spring动画

/*
 [UIView animateWithDuration:(NSTimeInterval)//动画持续时间
 delay:(NSTimeInterval)//动画延迟执行的时间
 usingSpringWithDamping:(CGFloat)//震动效果，范围0~1，数值越小震动效果越明显
 initialSpringVelocity:(CGFloat)//初始速度，数值越大初始速度越快
 options:(UIViewAnimationOptions)//动画的过渡效果
 animations:^{
 //执行的动画
 }
 completion:^(BOOL finished) {
 //动画执行提交后的操作
 }];
 
 */

#pragma mark -  关键帧动画
/*
 IOS7.0后新增了关键帧动画，支持属性关键帧，不支持路径关键帧
 方法1：
 [UIView animateKeyframesWithDuration:(NSTimeInterval)//动画持续时间
 delay:(NSTimeInterval)//动画延迟执行的时间
 options:(UIViewKeyframeAnimationOptions)//动画的过渡效果
 animations:^{
 //执行的关键帧动画
 }
 completion:^(BOOL finished) {
 //动画执行提交后的操作
 }];
 
 UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
 UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
 UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
 UIViewAnimationOptionRepeat                   //无限重复执行动画
 UIViewAnimationOptionAutoreverse              //执行动画回路
 UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
 UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置
 
 UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
 UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
 UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
 UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀
 
 方法2：
 [UIView addKeyframeWithRelativeStartTime:(double)//动画开始的时间（占总时间的比例）
 relativeDuration:(double) //动画持续时间（占总时间的比例）
 animations:^{
 //执行的动画
 }];
 

 */
#pragma mark -  过渡动画
/*
 方法1.从旧视图到新视图的动画效果
 
 [UIView transitionFromView:(nonnull UIView *) toView:(nonnull UIView *) duration:(NSTimeInterval) options:(UIViewAnimationOptions) completion:^(BOOL finished) {
 //动画执行提交后的操作
 }];
 在该动画过程中，fromView 会从父视图中移除，并将 toView 添加到父视图中，注意转场动画的作用对象是父视图（过渡效果体现在父视图上）。调用该方法相当于执行下面两句代码：
 
 [fromView.superview addSubview:toView];
 [fromView removeFromSuperview];
 
 方法2：单个视图的过渡效果
 
 [UIView transitionWithView:(nonnull UIView *)
 duration:(NSTimeInterval)
 options:(UIViewAnimationOptions)
 animations:^{
 //执行的动画
 }
 completion:^(BOOL finished) {
 //动画执行提交后的操作
 }];
 
 */
@end
