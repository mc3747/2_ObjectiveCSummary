//
//  IphoneSize.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/21.
//  Copyright © 2018年 macheng. All rights reserved.
//

#ifndef IphoneSize_h
#define IphoneSize_h

/**全屏宽高******************************/
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//按照iphone6系列给图的缩放比例
#define kScaleH      (SCREEN_HEIGHT/667.0)
#define kScaleW      (SCREEN_WIDTH/375.0)

//中文字体
#define CHINESE_FONT_NAME  @"Heiti SC"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

//字体随着屏幕的大小更改：R为默认字体大小
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))
#define AdaptedWidth(x)  ceilf((x) * kScaleW)
#define AdaptedHeight(x) ceilf((x) * kScaleH)

/**常用屏幕宽高******************************/

#define IS_IPHONEX_Serial (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 812.0)
// top安全高度
#define Top_SafeArea_HEIGHT (IS_IPHONEX_Serial ? 24.f : 0.f)
// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_IPHONEX_Serial ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (IS_IPHONEX_Serial ? (64.f + 24.f): 64.f)

// tabBar高度
#define TAB_BAR_HEIGHT (IS_IPHONEX_Serial ? (49.f+34.f) : 49.f)
// bottom安全高度
#define Bottom_SafeArea_HEIGHT (IS_IPHONEX_Serial ? 34.f : 0.f)


/**机型判断方法1：currentMode来判断******/
//判断是否是ipad或者iphone
#define is_Pad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define is_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//判断iPhone4系列
#define kIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone5系列
#define kIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhone6系列
#define kIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iphone6+系列
#define kIPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneX
#define kIPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define kIPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs
#define kIPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define kIPHONE_XMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

/**机型判断方法2：bounds结合DBL_EPSILON来判断******/
    //DBL_EPSILON和 FLT_EPSILON主要用于单精度和双精度的比较当中
#define IS_WIDESCREEN_5    (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < __DBL_EPSILON__)

#define IS_WIDESCREEN_6     (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < __DBL_EPSILON__)

#define IS_WIDESCREEN_6Plus  (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < __DBL_EPSILON__)

#define IS_WIDESCREEN_X  (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)812) < __DBL_EPSILON__)

#define IS_WIDESCREEN_XMax  (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)896) < __DBL_EPSILON__)

/**机型判断方法3：bounds的宽来判断******/
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6Plus (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)
#define IS_IPHONE_XMax (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 896.0)

/**机型判断方法4：device model来判断******/
    // 见iphoneDeviceInfo类

#endif /* IphoneSize_h */
