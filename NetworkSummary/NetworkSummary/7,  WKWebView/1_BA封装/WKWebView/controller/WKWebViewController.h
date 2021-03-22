//
//  WKWebViewController.h
//  WKWebViewController
//
//  Created by gjfax on 2020/1/7.
//  Copyright © 2020 MXCoder. All rights reserved.
//

#import <UIKit/UIKit.h>
// =====================================================
/*
 1，各种加载方式
 2，加载回调：成功，失败
 3，进度条
 4，分享
 5，清除缓存
 6，网络错误，无数据页面
 7,类似微信:退出,分享,底部向上滚动展示返回按钮,向下滚动则隐藏
 8，与js交互，
 */
// =====================================================
NS_ASSUME_NONNULL_BEGIN

@interface WKWebViewController : UIViewController
@property(nonatomic, strong) UIColor * _Nullable wk_web_progressTintColor;
@property(nonatomic, strong) UIColor *wk_web_progressTrackTintColor;

//加载自定义request
- (void)wk_web_loadRequest:(NSURLRequest *)request;

//加载URL
- (void)wk_web_loadURL:(NSURL *)URL;

//加载URLString
- (void)wk_web_loadURLString:(NSString *)URLString;

//加载本地网页：HTML 文件名
- (void)wk_web_loadHTMLFileName:(NSString *)htmlName;

//加载本地网页：htmlString
- (void)wk_web_loadHTMLString:(NSString *)htmlString;

//加载js字符串
- (void)wk_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
