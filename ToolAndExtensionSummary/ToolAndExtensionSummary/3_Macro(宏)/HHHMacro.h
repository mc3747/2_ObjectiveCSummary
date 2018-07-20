//
//  HHHMacro.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#ifndef HHHMacro_h
#define HHHMacro_h

/*******标准字符串 *******/
#define FMT_STR(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]
#define FMT_STRING( ...) [NSString stringWithFormat:@"%@", ##__VA_ARGS__]

/*******打印日志 *******/
#define DLog(fmt, ...) printf("%s [Line %d] %s  \n",__PRETTY_FUNCTION__, __LINE__,[[NSString stringWithFormat:(fmt), ##__VA_ARGS__] UTF8String]);

/*******系统版本 - 语言 *******/
// 获取当前系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//  是否高于ios7
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//  是否iOS11
#define IS_iOS11  ([CommonMethod checkoutIsiOS11])

//  获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


/*******判断机型 *******/
//  是否4inch
#define FourInch ([UIScreen mainScreen].bounds.size.height >= 568.0)

//  是否是ipad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//  是否是iphone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//  是否 Retina-4s屏、iphone5、iPad等
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

//  是否ipod
#define IS_IPOD                                    ([[[UIDevice currentDevice] model] isEqualToString: @"iPod touch"])

// 是否iphone5
#define iPhone5                                (IS_IPHONE && IS_WIDESCREEN_5)

// 是否iphone6
#define iPhone6                                (IS_IPHONE && IS_WIDESCREEN_6)

// 是否iphone6plus
#define iPhone6Plus                            (IS_IPHONE && IS_WIDESCREEN_6Plus)

// 是否iPhoneX
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)

//  设备屏宽
#define IS_WIDESCREEN_5                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < __DBL_EPSILON__)

#define IS_WIDESCREEN_6                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < __DBL_EPSILON__)

#define IS_WIDESCREEN_6Plus                        (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < __DBL_EPSILON__)


/*******安全距离，尺寸 *******/
//top 安全距离（不包括状态栏）
#define IPHONE_X_Top_Normal_Height  (IS_IPHONE_X == YES ? 24 : 0)

//top 安全距离（包括状态栏）
#define IPHONE_X_Top_SafeArea_Height  (IS_IPHONE_X == YES ? 44 : 0)

//bottom 底部安全距离
#define IPHONE_X_Bottom_SafeArea_Height  (IS_IPHONE_X == YES ? 34 : 0)

//键盘安全高度
#define KeyBoard_Height (216 + IPHONE_X_Bottom_SafeArea_Height + 39)

//  屏幕大小宽高尺寸
#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MAIN_SCREEN_BOUNDS [UIScreen mainScreen].bounds

#endif /* HHHMacro_h */
