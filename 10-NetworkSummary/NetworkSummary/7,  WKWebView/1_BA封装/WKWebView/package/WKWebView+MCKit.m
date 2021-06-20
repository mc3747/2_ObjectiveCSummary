//
//  WKWebView+MCKit.m
//  WKWebViewController
//
//  Created by gjfax on 2020/1/9.
//  Copyright © 2020 MXCoder. All rights reserved.
//

#import "WKWebView+MCKit.h"
#import "MCKit_ConfigurationDefine.h"
#import "WeakScriptMessageDelegate.h"

#define kBAKit_WK_title                 @"title"
#define kBAKit_WK_estimatedProgress     @"estimatedProgress"
#define kBAKit_WK_URL                   @"URL"
#define kBAKit_WK_contentSize           @"contentSize"

@interface WKWebView ()

@property (nonatomic, assign) CGFloat webViewHeigt;

@end

@implementation WKWebView (MCKit)
+ (void)load
{

    BAKit_Objc_exchangeMethodAToB(NSSelectorFromString(@"dealloc"),
                                  @selector(ba_web_dealloc));
}
//页面结束后的操作
- (void)ba_web_dealloc
{
    [self ba_removeNoti];
}

#pragma mark -  钩子函数
- (void)ba_web_initWithDelegate:(id<WKNavigationDelegate>)navigationDelegate
                     uIDelegate:(id<WKUIDelegate>)uIDelegate
{
    self.navigationDelegate = navigationDelegate;
    self.UIDelegate = uIDelegate;
    self.webViewHeigt = 0.f;
    [self ba_web_addNoti];
}
//获取通知
- (void)ba_web_addNoti
{
    // 获取页面标题
    [self addObserver:self
                   forKeyPath:kBAKit_WK_title
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 当前页面载入进度
    [self addObserver:self
                   forKeyPath:kBAKit_WK_estimatedProgress
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 监听 URL，当之前的 URL 不为空，而新的 URL 为空时则表示进程被终止
    [self addObserver:self
           forKeyPath:kBAKit_WK_URL
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
//    标题
    if ([keyPath isEqualToString:kBAKit_WK_title]){
        if (object == self){
            if (self.ba_web_getTitleBlock){
                self.ba_web_getTitleBlock(self.title);
            };
            if (self.ba_web_getCurrentUrlBlock){
                self.ba_web_getCurrentUrlBlock(self.URL);
            };
        }else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        };
        
//    进度条
    }else if ([keyPath isEqualToString:kBAKit_WK_estimatedProgress]){
        if (object == self)
        {
            if (self.ba_web_isLoadingBlock){
                self.ba_web_isLoadingBlock(self.loading, self.estimatedProgress);
            };
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        };
  
//     url
    }else if ([keyPath isEqualToString:kBAKit_WK_URL]){
        NSURL *newUrl = [change objectForKey:NSKeyValueChangeNewKey];
        NSURL *oldUrl = [change objectForKey:NSKeyValueChangeOldKey];
        if (![newUrl isKindOfClass:[NSURL class]] && [oldUrl isKindOfClass:[NSURL class]]) {
        };
        
//    内容尺寸
    }else if ([keyPath isEqualToString:kBAKit_WK_contentSize] && [object isEqual:self.scrollView]){
        
        __block CGFloat height = floorf([change[NSKeyValueChangeNewKey] CGSizeValue].height);
        if ( height != self.webViewHeigt ){
            self.webViewHeigt = height;
            CGRect frame = self.frame;
            frame.size.height = height;
            self.frame = frame;
            
            if ( self.ba_web_getCurrentHeightBlock ){
                self.ba_web_getCurrentHeightBlock(height);
            };
        }else if ( height == self.webViewHeigt && height > 0.f ){
            
        };
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    };
    
// 加载完成
    if (!self.loading)
    {
        NSLog(@"加载的URL：%@", self.URL.absoluteString);
        if (self.ba_web_isLoadingBlock){
            self.ba_web_isLoadingBlock(self.loading, 1.0F);
        }
    };
}
//移除通知
- (void)ba_removeNoti
{
    @try {
        //        Code that can potentially throw an exception[可能抛出异常的代码]
        [self removeObserver:self forKeyPath:kBAKit_WK_title];
        [self removeObserver:self forKeyPath:kBAKit_WK_estimatedProgress];
        [self removeObserver:self forKeyPath:kBAKit_WK_URL];
    } @catch (NSException *exception) {
        //        Handle an exception thrown in the @try block[处理@try块中抛出的异常]
    } @finally {
        //        Code that gets executed whether or not an exception is thrown[无论是否抛出异常，执行的代码都是被执行的]
    }
//    [self removeObserver:self forKeyPath:kBAKit_WK_title];
//    [self removeObserver:self forKeyPath:kBAKit_WK_estimatedProgress];
//    [self removeObserver:self forKeyPath:kBAKit_WK_URL];
    if ( self.ba_web_isAutoHeight )
    {
        [self.scrollView removeObserver:self forKeyPath:kBAKit_WK_contentSize];
    }
}

#pragma mark -  public method

//返回上一级页面
- (void)ba_web_goBack{
    if (self.canGoBack)
    {
        [self goBack];
    }
}
//进入下一级页面
- (void)ba_web_goForward{
    if (self.canGoForward)
       {
           [self goForward];
       }
}
//刷新 webView
- (void)ba_web_reload{
    [self reload];
}
//加载一个 webview：NSURLRequest
- (void)ba_web_loadRequest:(NSURLRequest *)request{
      [self loadRequest:request];
}
//加载一个 webview：NSURL
- (void)ba_web_loadURL:(NSURL *)URL{
     [self ba_web_loadRequest:[NSURLRequest requestWithURL:URL]];
}

//加载一个 webview：URLString
- (void)ba_web_loadURLString:(NSString *)URLString{
    [self ba_web_loadURL:[NSURL URLWithString:URLString]];
}
//加载一个 webview：htmlName
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName{
     NSString *htmlPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.html", htmlName] ofType:nil];
    if (htmlPath)
       {
           if (BAKit_IOS_VERSION >= 9.0)
           {
               NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
               [self loadFileURL:fileURL allowingReadAccessToURL:fileURL];
           } else {
               NSURL *fileURL = [self ba_fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:htmlPath]];
               NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
               [self loadRequest:request];
           }
       }
}
// 将文件copy到tmp目录
- (NSURL *)ba_fileURLForBuggyWKWebView8:(NSURL *)fileURL
{
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

//加载一个 webview：htmlString
- (void)ba_web_loadHTMLString:(NSString *)htmlString{
    /*! 一定要记得这一步，要不然本地的图片加载不出来 */
       NSString *basePath = [[NSBundle mainBundle] bundlePath];
       NSURL *baseURL = [NSURL fileURLWithPath:basePath];
       [self loadHTMLString:htmlString baseURL:baseURL];
}
// OC 调用 JS，加载 js 字符串，例如：高度自适应获取代码
- (void)ba_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id result, NSError * _Nullable error))completionHandler
{
    [self evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}
//JS 调用 OC
- (void)ba_web_addScriptMessageHandlerWithNameArray:(NSArray *)nameArray
{
    if ([nameArray isKindOfClass:[NSArray class]] && nameArray.count > 0)
    {
        [nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:obj];
        }];
    }
}

#pragma mark - 代理1：WKNavigationDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    webView.alpha = 0.f;
    if (self.ba_web_didStartBlock){
        self.ba_web_didStartBlock(webView, navigation);
    };
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (self.ba_web_didCommitBlock){
           self.ba_web_didCommitBlock(webView, navigation);
    };
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIView animateWithDuration:0.5f animations:^{
         webView.alpha = 1.f;
     }];
     if (self.ba_web_didFinishBlock)
        {
            self.ba_web_didFinishBlock(webView, navigation);
        }
        
        NSString *heightString4 = @"document.body.scrollHeight";

        if (self.ba_web_getCurrentHeightBlock && !self.ba_web_isAutoHeight){
            // webView 高度自适应
            [self ba_web_stringByEvaluateJavaScript:heightString4 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                // 获取页面高度，并重置 webview 的 frame
                NSLog(@"html 的高度：%@", result);
                self.ba_web_getCurrentHeightBlock([result doubleValue]);
            }];
        }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if (self.ba_web_didFailBlock){
           self.ba_web_didFailBlock(webView, navigation);
       }
}


//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}


// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
        NSURL *url = navigationAction.request.URL;
        NSString *url_scheme = url.scheme;
//        if ([url_scheme isEqualToString:self.ba_web_urlScheme])
//        {
//            if (self.ba_web_decidePolicyForNavigationActionBlock)
//            {
//                self.ba_web_decidePolicyForNavigationActionBlock(url);
//            }
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//        }
//
//        // APPStore
//        if ([url.absoluteString containsString:@"itunes.apple.com"])
//        {
//            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//        }
//
//        // 调用电话
//        if ([url.scheme isEqualToString:@"tel"])
//        {
//            if ([BAKit_SharedApplication canOpenURL:url])
//            {
//                [BAKit_SharedApplication openURL:url];
//                decisionHandler(WKNavigationActionPolicyCancel);
//                return;
//            }
//        };
        
        // 参数 WKNavigationAction 中有两个属性：sourceFrame 和 targetFrame，分别代表这个 action 的出处和目标，类型是 WKFrameInfo 。WKFrameInfo有一个 mainFrame 的属性，标记frame是在主frame里显示还是新开一个frame显示
    //    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    //    BOOL isMainframe = [frameInfo isMainFrame];
    //    NSLog(@"isMainframe :%d", isMainframe);
        
        // 此情况处理具体请看博客：http://www.jianshu.com/p/3a75d7348843
//        if (!navigationAction.targetFrame.isMainFrame){
//            [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
//
//        }else if ([BAKit_SharedApplication canOpenURL:url]){
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return;
//        };

        decisionHandler(WKNavigationActionPolicyAllow);
    
   
}

// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    // ⚠️必须实现decisionHandler的回调，否则就会报错
        decisionHandler(WKNavigationResponsePolicyAllow);
}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

//进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}

#pragma mark - 代理2：WKUIDelegate
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}

//JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
}

// 输入框
//JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
}

// 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
    
}

#pragma mark -  代理3-WKScriptMessageHandler
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if (self.ba_web_userContentControllerDidReceiveScriptMessageBlock)
    {
        self.ba_web_userContentControllerDidReceiveScriptMessageBlock(userContentController, message);
    }
}

- (BOOL)ba_web_canGoBack
{
    return [self canGoBack];
}
                      
- (BOOL)ba_web_canGoForward
{
    return [self canGoForward];
}

#pragma mark -  动态添加属性
//web高度
- (void)setWebViewHeigt:(CGFloat)webViewHeigt
{
    BAKit_Objc_setObj(@selector(webViewHeigt), @(webViewHeigt));
}

- (CGFloat)webViewHeigt
{
    return [BAKit_Objc_getObj floatValue];
}

//是否需要自动设定高度
- (void)setBa_web_isAutoHeight:(BOOL)ba_web_isAutoHeight
{
    BAKit_Objc_setObj(@selector(ba_web_isAutoHeight), @(ba_web_isAutoHeight));
    
    if ( ba_web_isAutoHeight )
    {
        // 监听高度变化
        [self.scrollView addObserver:self
                          forKeyPath:kBAKit_WK_contentSize
                             options:NSKeyValueObservingOptionNew
                             context:nil];
    }
}

- (BOOL)ba_web_isAutoHeight
{
    return [BAKit_Objc_getObj boolValue];
}

//需要拦截的 urlScheme
- (void)setBa_web_urlScheme:(NSString *)ba_web_urlScheme
{
    BAKit_Objc_setObj(@selector(ba_web_urlScheme), ba_web_urlScheme);
}

- (NSString *)ba_web_urlScheme
{
    return BAKit_Objc_getObj;
}

//开始加载时调用block
-(void)setBa_web_didStartBlock:(BAKit_webView_didStartProvisionalNavigationBlock)ba_web_didStartBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didStartBlock), ba_web_didStartBlock);
}

- (BAKit_webView_didStartProvisionalNavigationBlock)ba_web_didStartBlock
{
    return BAKit_Objc_getObj;
}

//当内容开始返回时调用block
- (void)setBa_web_didCommitBlock:(BAKit_webView_didCommitNavigationBlock)ba_web_didCommitBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didCommitBlock), ba_web_didCommitBlock);
}

- (BAKit_webView_didCommitNavigationBlock)ba_web_didCommitBlock
{
    return BAKit_Objc_getObj;
}

//页面加载完成之后调用block
- (void)setBa_web_didFinishBlock:(BAKit_webView_didFinishNavigationBlock)ba_web_didFinishBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didFinishBlock), ba_web_didFinishBlock);
}

- (BAKit_webView_didFinishNavigationBlock)ba_web_didFinishBlock
{
    return BAKit_Objc_getObj;
}

//页面加载失败时调用block
- (void)setBa_web_didFailBlock:(BAKit_webView_didFailProvisionalNavigationBlock)ba_web_didFailBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_didFailBlock), ba_web_didFailBlock);
}

- (BAKit_webView_didFailProvisionalNavigationBlock)ba_web_didFailBlock
{
    return BAKit_Objc_getObj;
}

//获取 webview 当前的加载进度，判断是否正在加载block
- (void)setBa_web_isLoadingBlock:(BAKit_webView_isLoadingBlock)ba_web_isLoadingBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_isLoadingBlock), ba_web_isLoadingBlock);
}

- (BAKit_webView_isLoadingBlock)ba_web_isLoadingBlock
{
    return BAKit_Objc_getObj;
}

//获取 webview 当前的 titleblock
- (void)setBa_web_getTitleBlock:(BAKit_webView_getTitleBlock)ba_web_getTitleBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_getTitleBlock), ba_web_getTitleBlock);
}

- (BAKit_webView_getTitleBlock)ba_web_getTitleBlock
{
    return BAKit_Objc_getObj;
}
//JS 调用 OC 时的block
- (void)setBa_web_userContentControllerDidReceiveScriptMessageBlock:(BAKit_webView_userContentControllerDidReceiveScriptMessageBlock)ba_web_userContentControllerDidReceiveScriptMessageBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_userContentControllerDidReceiveScriptMessageBlock), ba_web_userContentControllerDidReceiveScriptMessageBlock);
}

- (BAKit_webView_userContentControllerDidReceiveScriptMessageBlock)ba_web_userContentControllerDidReceiveScriptMessageBlock
{
    return BAKit_Objc_getObj;
}
//拦截url的block
- (void)setBa_web_decidePolicyForNavigationActionBlock:(BAKit_webView_decidePolicyForNavigationActionBlock)ba_web_decidePolicyForNavigationActionBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_decidePolicyForNavigationActionBlock), ba_web_decidePolicyForNavigationActionBlock);
}

- (BAKit_webView_decidePolicyForNavigationActionBlock)ba_web_decidePolicyForNavigationActionBlock
{
    return BAKit_Objc_getObj;
}

//获取 webview 当前的 URL的block
- (void)setBa_web_getCurrentUrlBlock:(BAKit_webView_getCurrentUrlBlock)ba_web_getCurrentUrlBlock
{
    BAKit_Objc_setObjCOPY(@selector(ba_web_getCurrentUrlBlock), ba_web_getCurrentUrlBlock);
}

- (BAKit_webView_getCurrentUrlBlock)ba_web_getCurrentUrlBlock
{
    return BAKit_Objc_getObj;
}

//获取 webview 当前的 currentHeight的block
- (void)setBa_web_getCurrentHeightBlock:(BAKit_webView_getCurrentHeightBlock)ba_web_getCurrentHeightBlock
{
    BAKit_Objc_setObj(@selector(ba_web_getCurrentHeightBlock), ba_web_getCurrentHeightBlock);
}

- (BAKit_webView_getCurrentHeightBlock)ba_web_getCurrentHeightBlock
{
    return BAKit_Objc_getObj;
}


@end
