//
//  BSYLoading.m
//  BSYLoading
//
//  Created by 白仕云 on 2018/5/17.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

// 默认菊花颜色
#define DefalutCrazyCircleColor [UIColor whiteColor]
// 默认菊花背景颜色
#define DefalutCrazyCircleBgColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]

// 文本默认颜色
#define DefalutTextTextColor [UIColor blackColor]
// 文本默认对齐方式
#define DefalutTextTextAlignment NSTextAlignmentCenter
// 文本默认字体大小
#define DefalutTextTextFont  17.00
// 获取最后一个有效Window
#define MainWindow [UIApplication sharedApplication].windows.lastObject

//默认背景宽度
#define DefalutBGWith  150

#define bgViewTag 99999999999999
#import "BSYLoading.h"

@interface BSYLoading()
@end
@implementation BSYLoading

/**
 菊花
 */
+(void)showCrazyCircle
{


    if ([self have]==true) {
        return;
    }
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.frame = CGRectMake(50, 0, 50, 50);
    UIView *bgView =  [self returnBgView];
    [bgView addSubview:loading];
    [self setAnimationWithloadingImage:loading];
}

/**
 菊花颜色自定义
 @param CircleColor 菊花颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor
{

    if ([self have]==true) {
        return;
    }
    CircleColor =CircleColor?CircleColor:DefalutCrazyCircleColor;
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.frame = CGRectMake(50, 0, 50, 50);
    loading.image = [self imageWithColor:CircleColor Image:loading.image];
    UIView *bgView =  [self returnBgView];
    [bgView addSubview:loading];
    [self setAnimationWithloadingImage:loading];
}

/**
 菊花颜色自定义  背景颜色自定义
 @param BgColor 背景颜色
 @param CircleColor 菊花颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor
{

    if ([self have]==true) {
        return;
    }
    CircleColor =CircleColor?CircleColor:DefalutCrazyCircleColor;
    BgColor  =BgColor?BgColor:DefalutCrazyCircleBgColor;
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.image = [self imageWithColor:CircleColor Image:loading.image];
    loading.frame = CGRectMake(50, 0, 50, 50);
    UIView *bgView =  [self returnBgView];
    bgView.backgroundColor = BgColor;
    [bgView addSubview:loading];
    [self setAnimationWithloadingImage:loading];

}

// #############################################   有文本信息       ###################################

/**
 文字和菊花
 @param text 文本信息
 */
+(void)showCrazyCircleWithText:(NSString *)text

{

    if ([self have]==true) {
        return;
    }
    text  =text?([text isEqualToString:@""]?@"加载中···":text):@"加载中···";

    //菊花
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    //文本
    UILabel *Text  =[self returnTextString];
    Text.text = text;
    UIView *bgView =  [self returnBgView];

    //计算文本宽度，更新背景/Lable宽度
    CGFloat With = [self widthForString:text fontSize:DefalutTextTextFont];
    if (With>DefalutBGWith){
        bgView.frame = CGRectMake((MainWindow.bounds.size.width-With)/2.0, (MainWindow.bounds.size.height-50)/2.0, With, 50);
        Text.frame =CGRectMake(50, 0, With-50, 50);
    }

    [bgView addSubview:Text];
    [bgView addSubview:loading];
    //动画
    [self setAnimationWithloadingImage:loading];

}

/**
 文字和菊花
 @param CircleColor 菊花颜色
 @param text 文本信息
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor Text:(NSString *)text
{
    if ([self have]==true) {
        return;
    }

    CircleColor =CircleColor?CircleColor:DefalutCrazyCircleColor;
    text  =text?([text isEqualToString:@""]?@"加载中···":text):@"加载中···";
    //菊花
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.image = [self imageWithColor:CircleColor Image:loading.image];
    //文本
    UILabel *Text  =[self returnTextString];
    Text.text = text;
    UIView *bgView =  [self returnBgView];

    //计算文本宽度，更新背景/Lable宽度
    CGFloat With = [self widthForString:text fontSize:DefalutTextTextFont];
    if (With>DefalutBGWith){
        bgView.frame = CGRectMake((MainWindow.bounds.size.width-With)/2.0, (MainWindow.bounds.size.height-50)/2.0, With, 50);
        Text.frame =CGRectMake(50, 0, With-50, 50);
    }
    [bgView addSubview:Text];
    [bgView addSubview:loading];
    //动画
    [self setAnimationWithloadingImage:loading];

}
/**
 文字和菊花
 @param CircleColor 菊花颜色
 @param text 文本信息
 @param TextColor 文本颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor Text:(NSString *)text TextColor:(UIColor *)TextColor
{


    NSLog(@"   %d",[self have]);
    if ([self have]==true) {
        return;
    }
    text  =text?([text isEqualToString:@""]?@"加载中···":text):@"加载中···";
    CircleColor =CircleColor?CircleColor:DefalutCrazyCircleColor;
    TextColor = TextColor?TextColor:DefalutTextTextColor;
    //菊花
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.image = [self imageWithColor:CircleColor Image:loading.image];
    //文本
    UILabel *Text  =[self returnTextString];
    Text.textColor = TextColor;
    Text.text = text;
    UIView *bgView =  [self returnBgView];

    //计算文本宽度，更新背景/Lable宽度
    CGFloat With = [self widthForString:text fontSize:DefalutTextTextFont];
    if (With>DefalutBGWith){
        bgView.frame = CGRectMake((MainWindow.bounds.size.width-With)/2.0, (MainWindow.bounds.size.height-50)/2.0, With, 50);
        Text.frame =CGRectMake(50, 0, With-50, 50);
    }
    [bgView addSubview:Text];
    [bgView addSubview:loading];
    //动画
    [self setAnimationWithloadingImage:loading];

}

/**
 文字菊花效果
 @param CircleColor 菊花颜色
 @param BgColor 波浪背景颜色
 @param text 文本信息
 @param TextColor 文本颜色
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor Text:(NSString *)text TextColor:(UIColor *)TextColor
{

    if ([self have]==true) {
        return;
    }
    text  =text?([text isEqualToString:@""]?@"加载中···":text):@"加载中···";
    CircleColor =CircleColor?CircleColor:DefalutCrazyCircleColor;
    BgColor  =BgColor?BgColor:DefalutCrazyCircleBgColor;
    TextColor = TextColor?TextColor:DefalutTextTextColor;
    //菊花
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.image = [self imageWithColor:CircleColor Image:loading.image];
    //文本
    UILabel *Text  =[self returnTextString];
    Text.textColor = TextColor;
    Text.text = text;
    UIView *bgView =  [self returnBgView];
    bgView.backgroundColor = BgColor;

    //计算文本宽度，更新背景/Lable宽度
    CGFloat With = [self widthForString:text fontSize:DefalutTextTextFont];
    if (With>DefalutBGWith){
        bgView.frame = CGRectMake((MainWindow.bounds.size.width-With)/2.0, (MainWindow.bounds.size.height-50)/2.0, With, 50);
        Text.frame =CGRectMake(50, 0, With-50, 50);
    }
    [bgView addSubview:Text];
    [bgView addSubview:loading];
    //动画
    [self setAnimationWithloadingImage:loading];

}

/**
 文字和菊花
 @param CircleColor 菊花颜色
 @param BgColor 波浪背景颜色
 @param text 文本信息
 @param TextColor 文本颜色
 @param TextFont 文本字体
 */

+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor Text:(NSString *)text TextColor:(UIColor *)TextColor TextFont:(CGFloat)TextFont
{

    if ([self have]==true) {
        return;
    }
    text  =text?([text isEqualToString:@""]?@"加载中···":text):@"加载中···";
    CircleColor =CircleColor?CircleColor:DefalutCrazyCircleColor;
    BgColor  =BgColor?BgColor:DefalutCrazyCircleBgColor;
    TextColor = TextColor?TextColor:DefalutTextTextColor;
    TextFont = TextFont?TextFont:(CGFloat)DefalutTextTextFont;

    //菊花
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.image = [self imageWithColor:CircleColor Image:loading.image];
    //文本
    UILabel *Text  =[self returnTextString];
    Text.textColor = TextColor;
    Text.text = text;
    Text.font =[UIFont systemFontOfSize:TextFont];

    UIView *bgView =  [self returnBgView];
    bgView.backgroundColor = BgColor;

    //计算文本宽度，更新背景/Lable宽度
    CGFloat With = [self widthForString:text fontSize:DefalutTextTextFont];
    if (With>DefalutBGWith){
        bgView.frame = CGRectMake((MainWindow.bounds.size.width-With)/2.0, (MainWindow.bounds.size.height-50)/2.0, With, 50);
        Text.frame =CGRectMake(50, 0, With-50, 50);
    }
    [bgView addSubview:Text];
    [bgView addSubview:loading];
    //动画
    [self setAnimationWithloadingImage:loading];
}

/**
 文字和菊花
 @param CircleColor 菊花颜色
 @param BgColor 背景颜色
 @param text 文本信息
 @param TextColor 文本颜色
 @param TextFont 文本字体
 @param TextAlignment 文本对其方法
 */
+(void)showCrazyCircleWithColor:(UIColor *)CircleColor BgColor:(UIColor *)BgColor Text:(NSString *)text TextColor:(UIColor *)TextColor TextFont:(CGFloat)TextFont TextAlignment:(NSTextAlignment)TextAlignment
{

    if ([self have]==true) {
        return;
    }
    text  =text?([text isEqualToString:@""]?@"加载中···":text):@"加载中···";
    CircleColor =CircleColor?CircleColor:DefalutCrazyCircleColor;
    BgColor  = BgColor?BgColor:DefalutCrazyCircleBgColor;
    TextColor = TextColor?TextColor:DefalutTextTextColor;
    TextFont = TextFont?TextFont:(CGFloat)DefalutTextTextFont;
    TextAlignment = TextAlignment?TextAlignment:DefalutTextTextAlignment;

    //菊花
    UIImageView *loading = [self returnCrazyCircleLoadingView];
    loading.image = [self imageWithColor:CircleColor Image:loading.image];

    //文本
    UILabel *Text  =[self returnTextString];
    Text.textColor = TextColor;
    Text.text = text;
    Text.font =[UIFont systemFontOfSize:TextFont];
    Text.textAlignment = TextAlignment;
    UIView *bgView =  [self returnBgView];
    bgView.backgroundColor = BgColor;

    //计算文本宽度，更新背景/Lable宽度
    CGFloat With = [self widthForString:text fontSize:DefalutTextTextFont];
    if (With>DefalutBGWith){
        bgView.frame = CGRectMake((MainWindow.bounds.size.width-With)/2.0, (MainWindow.bounds.size.height-50)/2.0, With, 50);
        Text.frame =CGRectMake(50, 0, With-50, 50);
    }
    [bgView addSubview:Text];
    [bgView addSubview:loading];
    //动画
    [self setAnimationWithloadingImage:loading];
    
}
/**
 判断菊花是不是已经存在
 @return true是存在。False是不存在
 */
+(BOOL)have
{
    BOOL haveBool = false;
    for (UIView *bgView in MainWindow.subviews) {
        if (bgView.tag==bgViewTag) {
            haveBool = true;
        }
    }
    return haveBool;
}

/**
 隐藏菊花
 */
+(void)hidenCrazyCircleAnimation
{
    for (UIView *bgView in MainWindow.subviews) {
        if (bgView.tag==bgViewTag) {
            [UIView animateWithDuration:0.5 animations:^{
                bgView.alpha = 0;
            } completion:^(BOOL finished) {
                bgView.alpha = 0;
                [bgView removeFromSuperview];
            }];
        }
    }
}

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
+(UIImage *)imageWithColor:(UIColor *)color Image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, 50, 50);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 菊花动画
 */
+(void)setAnimationWithloadingImage:(UIImageView *)loading
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 1秒后执行
//    animation.beginTime = 0.1f;
    // 重复次数
    animation.repeatCount = MAXFLOAT;
    // 时间
    animation.duration = 1.f;
    // 是否累积
    animation.cumulative = YES;
    // 起始角度
//    animation.fromValue = @(0.0);
    // 终止角度
    animation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    // 添加动画
    [loading.layer addAnimation:animation forKey:@"rotationAnimation"];
}

/**
 创建 CrazyCircle
 @return 返回创建的View
 */
+(UIImageView *)returnCrazyCircleLoadingView
{
    UIImageView *loading = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    loading.backgroundColor = [UIColor clearColor];
    loading.image = [UIImage imageNamed:@"loading.png"];
    loading.layer.borderWidth =1;
    loading.layer.borderColor = [UIColor clearColor].CGColor;
    loading.layer.cornerRadius = 25;
    return loading;
}

/**
 创建背景View
 @return 返回创建的View
 */
+(UIView *)returnBgView
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake((MainWindow.bounds.size.width-DefalutBGWith)/2.0, (MainWindow.bounds.size.height-50)/2.0, DefalutBGWith, 50)];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [MainWindow addSubview:bgView];
    bgView.layer.borderWidth =1;
    bgView.layer.borderColor =  [UIColor clearColor].CGColor;
    bgView.layer.cornerRadius = 5;
    bgView.tag =bgViewTag;
    return bgView;
}

/**
 创建Text
 @return 返回创建的View
 */
+(UILabel *)returnTextString
{
    UILabel *bgView = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 100, 50)];
    bgView.textColor  =[UIColor whiteColor];
    bgView.font = [UIFont systemFontOfSize:DefalutTextTextFont];
    bgView.textAlignment = DefalutTextTextAlignment;
    return bgView;
}


/**
 计算文本宽度

 @param value 字符串
 @param fontSize 文本大小
 @return 返回文本宽度
 */
+(CGFloat)widthForString:(NSString *)value fontSize:(CGFloat)fontSize
{
    CGSize size = [value sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    //获取宽高
    CGSize statuseStrSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    if (statuseStrSize.width>=MainWindow.bounds.size.width) {
        statuseStrSize.width =MainWindow.bounds.size.width-20;
    }
    return statuseStrSize.width;
}
@end
