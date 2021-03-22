//
//  MCKit__ConfigurationDefine.h
//  WKWebViewController
//
//  Created by gjfax on 2020/1/9.
//  Copyright © 2020 MXCoder. All rights reserved.
//

#ifndef MCKit_ConfigurationDefine_h
#define MCKit_ConfigurationDefine_h
// =====================================================
/*
 weak / strong
 */
// =====================================================
#define GJWeakSelf  __weak typeof(self) weakSelf = self;
#define GJStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;


// 操作系统版本号
#define BAKit_IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

/*!
 *  获取屏幕宽度和高度
 */
#define BAKit_SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define BAKit_SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

/*! 获取sharedApplication */
#define BAKit_SharedApplication    [UIApplication sharedApplication]

/*! 用safari打开URL */
#define BAKit_OpenUrl(urlStr)      [BAKit_SharedApplication openURL:[NSURL URLWithString:urlStr]]

/*! 复制文字内容 */
#define BAKit_CopyContent(content) [[UIPasteboard generalPasteboard] setString:content]

// =====================================================
/*
 runtime相关
 */
// =====================================================
#import <objc/runtime.h>

/*! runtime set */
#define BAKit_Objc_setObj(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

/*! runtime setCopy */
#define BAKit_Objc_setObjCOPY(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY)

/*! runtime get */
#define BAKit_Objc_getObj objc_getAssociatedObject(self, _cmd)

/*! runtime交换方法 exchangeMethod */
#define BAKit_Objc_exchangeMethodAToB(originalSelector,swizzledSelector) { \
Method originalMethod = class_getInstanceMethod(self, originalSelector); \
Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector); \
if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) { \
class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)); \
} else { \
method_exchangeImplementations(originalMethod, swizzledMethod); \
} \
}

#endif /* MCKit__ConfigurationDefine_h */
