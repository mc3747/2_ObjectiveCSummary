//
//  WKWebViewController.m
//  WKWebViewController
//
//  Created by gjfax on 2020/1/7.
//  Copyright © 2020 MXCoder. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "MCKit_WKWebView.h"

@interface WKWebViewController ()
@property(nonatomic, strong) WKWebView *wk_webView;
@property(nonatomic, strong) WKWebViewConfiguration *wk_webConfig;
@property(nonatomic, strong) UIProgressView *wk_progressView;
@property(nonatomic, strong) NSURL *wk_currentUrl;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setupUI];
}
- (void)dealloc
{
    [self.wk_webView removeFromSuperview];
    [self.wk_progressView removeFromSuperview];
    self.wk_webView = nil;
    self.wk_webConfig = nil;
    self.wk_progressView = nil;
    self.wk_currentUrl = nil;
}

- (BOOL)willDealloc
{
    return NO;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.wk_webView.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, BAKit_SCREEN_HEIGHT);
    self.wk_progressView.frame = CGRectMake(0, 64, BAKit_SCREEN_WIDTH, 20);
}
#pragma mark -  基础UI
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.wk_webView.hidden = NO;
    [self configBackItem];
    [self configMenuItem];
    [self webviewLifeAction];
}

-(void)webviewLifeAction{
        GJWeakSelf
        self.wk_webView.ba_web_didStartBlock = ^(WKWebView *webView, WKNavigation *navigation) {
            
            NSLog(@"开始加载网页");
        };
        
        self.wk_webView.ba_web_didFinishBlock = ^(WKWebView *webView, WKNavigation *navigation) {
            NSLog(@"加载网页结束");
            
            // WKWebview 禁止长按(超链接、图片、文本...)弹出效果
            [webView ba_web_stringByEvaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none'" completionHandler:nil];
        };
        
        self.wk_webView.ba_web_isLoadingBlock = ^(BOOL isLoading, CGFloat progress) {
            GJStrongSelf
            [strongSelf ba_web_progressShow];
            strongSelf.wk_progressView.progress = progress;
            if (strongSelf.wk_progressView.progress == 1.0f)
            {
                [strongSelf ba_web_progressHidden];
            }
        };
        
        self.wk_webView.ba_web_getTitleBlock = ^(NSString *title) {
            
            GJStrongSelf
            // 获取当前网页的 title
            strongSelf.title = title;
        };
        
        self.wk_webView.ba_web_getCurrentUrlBlock = ^(NSURL * _Nonnull currentUrl) {
            GJStrongSelf
            strongSelf.wk_currentUrl = currentUrl;
        };
    
}
#pragma mark 导航栏左侧的返回按钮
- (void)configBackItem
{
    UIImage *backImage = [UIImage imageNamed:@"BAKit_WebView.bundle/navigationbar_back"];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *backBtn = [[UIButton alloc] init];
    //    [backBtn setTintColor:BAKit_ColorOrange];
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn sizeToFit];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = colseItem;
}
-(void)backBtnAction:(id)sender{
    if (self.wk_webView.ba_web_canGoBack)
       {
           [self.wk_webView ba_web_goBack];
           if (self.navigationItem.leftBarButtonItems.count == 1)
           {
               [self configColseItem];
           }
       }
       else
       {
           [self.navigationController popViewControllerAnimated:YES];
       }
}
#pragma mark 导航栏的关闭按钮
- (void)configColseItem
{
    UIButton *colseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [colseBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [colseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [colseBtn addTarget:self action:@selector(colseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [colseBtn sizeToFit];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:colseBtn];
    
    NSMutableArray *newArr = [NSMutableArray arrayWithObjects:self.navigationItem.leftBarButtonItem,colseItem, nil];
    self.navigationItem.leftBarButtonItems = newArr;
}
#pragma mark 导航栏右侧的菜单按钮
- (void)configMenuItem
{
    UIImage *menuImage = [UIImage imageNamed:@"BAKit_WebView.bundle/navigationbar_more"];
    menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *menuBtn = [[UIButton alloc] init];
    //    [menuBtn setTintColor:BAKit_ColorOrange];
    [menuBtn setImage:menuImage forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [menuBtn sizeToFit];
    
    UIBarButtonItem *menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItem = menuItem;
}
-(void)menuBtnAction:(id)sender{
    
}


//加载自定义request
- (void)wk_web_loadRequest:(NSURLRequest *)request{
    [self.wk_webView ba_web_loadRequest:request];
}

//加载URL
- (void)wk_web_loadURL:(NSURL *)URL{
    [self.wk_webView ba_web_loadURL:URL];
}

//加载URLString
- (void)wk_web_loadURLString:(NSString *)URLString{
    [self.wk_webView ba_web_loadURLString:URLString];
}

//加载本地网页：HTML 文件名
- (void)wk_web_loadHTMLFileName:(NSString *)htmlName{
    [self.wk_webView ba_web_loadHTMLFileName:htmlName];
}

//加载本地网页：htmlString
- (void)wk_web_loadHTMLString:(NSString *)htmlString{
    [self.wk_webView ba_web_loadHTMLString:htmlString];
}

//加载js字符串
- (void)wk_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler{
    [self.wk_webView ba_web_stringByEvaluateJavaScript:javaScriptString completionHandler:completionHandler];
}
#pragma mark -  显示进度条
- (void)ba_web_progressShow
{
    // 开始加载网页时展示出progressView
    self.wk_progressView.hidden = NO;
    // 开始加载网页的时候将progressView的Height恢复为1.5倍
    self.wk_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    // 防止progressView被网页挡住
    [self.navigationController.view bringSubviewToFront:self.wk_progressView];
}
#pragma mark -  隐藏进度条
- (void)ba_web_progressHidden
{
/*添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
     *动画时长0.25s，延时0.3s后开始动画
     *动画结束后将progressView隐藏
     */
    [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.wk_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
    } completion:^(BOOL finished) {
        self.wk_progressView.hidden = YES;
        
    }];
}
#pragma mark -  懒加载
- (WKWebView *)wk_webView
{
    if (!_wk_webView)
    {
        _wk_webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.wk_webConfig];
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        [self.wk_webView ba_web_initWithDelegate:self.wk_webView uIDelegate:self.wk_webView];
        _wk_webView.ba_web_isAutoHeight = NO;
        self.wk_webView.multipleTouchEnabled = YES;
        self.wk_webView.autoresizesSubviews = YES;
        [self.view addSubview:self.wk_webView];
    }
    return _wk_webView;
}
- (WKWebViewConfiguration *)wk_webConfig
{
    if (!_wk_webConfig) {
        
        // 创建并配置WKWebView的相关参数
        // 1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
        // 2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
        // 3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
        
        _wk_webConfig = [[WKWebViewConfiguration alloc] init];
        _wk_webConfig.allowsInlineMediaPlayback = YES;
        
//        _webConfig.allowsPictureInPictureMediaPlayback = YES;
        
        // 通过 JS 与 webView 内容交互
        // 注入 JS 对象名称 senderModel，当 JS 通过 senderModel 来调用时，我们可以在WKScriptMessageHandler 代理中接收到
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        //        [userContentController addScriptMessageHandler:self name:@"BAShare"];
        _wk_webConfig.userContentController = userContentController;
        
        // 初始化偏好设置属性：preferences
        _wk_webConfig.preferences = [WKPreferences new];
        // The minimum font size in points default is 0;
        _wk_webConfig.preferences.minimumFontSize = 40;
        // 是否支持 JavaScript
        _wk_webConfig.preferences.javaScriptEnabled = YES;
        // 不通过用户交互，是否可以打开窗口
        _wk_webConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    }
    return _wk_webConfig;
}
- (UIProgressView *)wk_progressView
{
    if (!_wk_progressView)
    {
        _wk_progressView = [UIProgressView new];
        _wk_progressView.tintColor = [UIColor redColor];
        _wk_progressView.trackTintColor = [UIColor yellowColor];
        self.wk_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self.view addSubview:_wk_progressView];
    }
    return _wk_progressView;
}
@end
