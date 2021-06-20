//
//  CommonSizeDefine.h
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2017/12/27.
//  Copyright © 2017年 macheng. All rights reserved.
//

#ifndef CommonSizeDefine_h
#define CommonSizeDefine_h

//  iphone 和 ipad判断
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//  设备屏宽
#define IS_WIDESCREEN_5                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < __DBL_EPSILON__)
#define IS_WIDESCREEN_6                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < __DBL_EPSILON__)
#define IS_WIDESCREEN_6Plus                        (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < __DBL_EPSILON__)
#define IS_IPHONE_X (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)

//  屏幕大小
#define MAIN_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define MAIN_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//  iphoneX安全距离
#define IPHONE_X_Top_SafeArea_Height  (IS_IPHONE_X == YES ? 44 : 0)
#define IPHONE_X_Bottom_SafeArea_Height  (IS_IPHONE_X == YES ? 34 : 0)

//  顶部状态状态栏高度（刘海高度24）
#define STATUS_BAR_HEIGHT (IS_IPHONE_X == YES ? 44 : 20)
//  顶部导航栏高度（包括顶部刘海 + 状态栏 + 标题栏）
#define NAVI_HEIGHT (IS_IPHONE_X == YES ? 88 : 64)
//  底部标签栏高度
#define TabbarHeight (IS_IPHONE_X == YES ? 88 : 49)
//  安全键盘
#define KeyBoard_Height (216 + IPHONE_X_Bottom_SafeArea_Height + 39)


#endif /* CommonSizeDefine_h */
