//
//  WKWebViewSummaryVC.m
//  排序总结
//
//  Created by gjfax on 2019/3/21.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "WKWebViewSummaryVC.h"
#import <WebKit/WebKit.h>
#import "SimpleJsWithWKVC.h"
#import <AFNetworking.h>

#define POST_JS @"function my_post(path, params) {\
var method = \"POST\";\
var form = document.createElement(\"form\");\
form.setAttribute(\"method\", method);\
form.setAttribute(\"action\", path);\
for(var key in params){\
    if (params.hasOwnProperty(key)) {\
        var hiddenFild = document.createElement(\"input\");\
        hiddenFild.setAttribute(\"type\", \"hidden\");\
        hiddenFild.setAttribute(\"name\", key);\
        hiddenFild.setAttribute(\"value\", params[key]);\
    }\
    form.appendChild(hiddenFild);\
}\
document.body.appendChild(form);\
form.submit();\
}"

@interface WKWebViewSummaryVC ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) Boolean needLoadJSPOST;
@end

@implementation WKWebViewSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTopUI];
    [self setWKWebview];
    [self setBottomUI1];
    [self setGetRequest];
//    [self getDemo];
    [self postDemo];
}
-(void)getDemo{
    NSDictionary *dict = @{
                              @"gqdm":@"161248",
                              @"applicationId":@"110929"
                              };
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [manager GET:@"https://app.gjfax.com/APP_SERVER/remote/trading/getLegalAgreement?" parameters:dict progress:nil success:
        ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               NSLog(@"请求成功---%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败,服务器返回的错误信息%@",error);
        }];
}

-(void)postDemo{
    //请求的参数
       NSDictionary *parameters = @{
           @"origin":@{
                   @"apiVersion" : @"1.3",
                         @"appVersion" : @"3.34.0",
                         @"channel" : @950,
                         @"phoneType" : @"iPhone 6s",
                         @"platform" : @5,
                         @"reqId" : @"600E2CE628F087DD1256B37B0839025C",
                         @"sysVersion" : @"iOS_13.3",
                         @"timestamp" : @"1578465610000",
                   @"uuid" : @"B86D519D-83F7-4C86-906D-3F9D16FF9994"
           },
           @"param":@"",
           @"security":@{
                   @"secCode" : @0,
                   @"secType" : @0
           }
                                    };
       //请求的url
       NSString *urlString = @"https://app.gjfax.com/APP_SERVER/remote/trading/getLegalAgreement?gqdm=161248&applicationId=110929";
       //请求的managers
       AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
       managers.requestSerializer=[AFJSONRequestSerializer serializer];
       managers.responseSerializer=[AFJSONResponseSerializer serializer];
       managers.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/javascript",@"application/pdf",@"application/octet-stream", nil];
       [managers POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSLog(@"请求成功,服务器返回的信息%@",responseObject);
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"请求失败,服务器返回的错误信息%@",error);
       }];
}

// get请求
-(void)setGetRequest{
    
//    NSString *urlStr = @"https://www.baidu.com";
    
    NSString *urlStr = @"https://app.gjfax.com/APP_SERVER/remote/trading/getLegalAgreement?gqdm=161248&applicationId=110929";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
//     NSData *data = [NSData dataWithContentsOfURL:url];
//    [_webView loadData:data MIMEType:@"application/pdf" characterEncodingName:@"UTF-8" baseURL:url];
}

// post请求
-(void)setPostRequest{
    //  1、将一个包含JavaScript的POST请求的HTML代码放到工程目录中 2、加载这个包含JavaScript的POST请求的代码到WKWebView 3、加载完成之后，用Native调用JavaScript的POST方法并传入参数来完成请求
    
    // JS发送POST的Flag，为真的时候会调用JS的POST方法（仅当第一次的时候加载本地JS）
    self.needLoadJSPOST = YES;
    // 获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSPOST" ofType:@"html"];
    // 获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    // 加载js
    [self.webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

// post用宏封装
-(void)setPostRequest2{
    self.needLoadJSPOST = NO;
    // 要传递的参数，（在开发中可以字典转成json字符串即可）
      NSString * dataStr = @"{\"token\":\"cac6af340960485aa334416c8a34ddbf\"}";    // 发送的地址
      NSString * url = @"http://192.168.1.36:8000/show_meta/";    // 最终要执行的JS代码
      NSString * js = [NSString stringWithFormat:@"%@my_post(\"%@\", %@)",POST_JS,url,dataStr];    // 执行JS代码
       [self.webView evaluateJavaScript:js completionHandler:^(id object, NSError * _Nullable error) {
          NSLog(@"Javascript: %@", object);
      }];
}

// 调用JS发送POST请求
 - (void)postRequestWithJS {
     // 发送POST的参数
     NSString *postData = @"\"username\":\"aaa\",\"password\":\"123\"";
     // 请求的页面地址
     NSString *urlStr = @"http://www.postexample.com";
     // 拼装成调用JavaScript的字符串
     NSString *jscript = [NSString stringWithFormat:@"post('%@', {%@});", urlStr, postData];

      NSLog(@"Javascript: %@", jscript);
     // 调用JS代码
     [self.webView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
         NSLog(@"Javascript: %@", object);
     }];
 }

//顶部UI
-(void)setTopUI{
    self.navigationController.navigationBar.translucent = YES;
     self.title = @"WKWebView基本使用";
     UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClicked:)];
     self.navigationItem.leftBarButtonItem = backItem;
     
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"js交互" style:UIBarButtonItemStylePlain target:self action:@selector(moreItemClicked:)];
}

//WKWebView
-(void)setWKWebview{
//    ⚠️分类里边不能写center，否则WKWebView只会显示一半
       // 设置偏好设置
       WKWebViewConfiguration *webConfiguration = [[WKWebViewConfiguration alloc] init];
       // 默认为0
       webConfiguration.preferences.minimumFontSize = 10;
       //是否支持JavaScript
       webConfiguration.preferences.javaScriptEnabled = YES;
       //不通过用户交互，是否可以打开窗口
       webConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
       webConfiguration.dataDetectorTypes = WKDataDetectorTypePhoneNumber;
       _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT - 64) configuration:webConfiguration];
       _webView.backgroundColor = [UIColor whiteColor];
       // 允许左滑右滑手势
       _webView.allowsBackForwardNavigationGestures = YES;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
       [self.view addSubview:_webView];
}

-(void)setBottomUI1{
 
    CGFloat toolBarH = 44.0;
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.barTintColor = [UIColor lightGrayColor];
    toolBar.frame = (CGRect){.0, CGRectGetHeight(self.view.frame) - toolBarH - [[UIApplication sharedApplication].windows firstObject].safeAreaInsets.bottom, CGRectGetWidth(self.view.frame), toolBarH};
    [self.view addSubview:toolBar];
    
    UIBarButtonItem *forwardItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(forwardButtonClicked:)];
    
    UIBarButtonItem *backwardItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(backwardButtonClicked:)];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refreshButtonClicked:)];
    
    UIBarButtonItem *backforwardListItem = [[UIBarButtonItem alloc] initWithTitle:@"列表" style:UIBarButtonItemStyleDone target:self action:@selector(backforwardListItemClicked:)];
    
//    UIBarButtonItem *snapItem = [[UIBarButtonItem alloc] initWithTitle:@"截图" style:UIBarButtonItemStyleDone target:self action:@selector(snapItemClicked:)];
    
    UIBarButtonItem *getItem = [[UIBarButtonItem alloc] initWithTitle:@"get" style:UIBarButtonItemStyleDone target:self action:@selector(setGetRequest)];
    
    UIBarButtonItem *postItem = [[UIBarButtonItem alloc] initWithTitle:@"post1" style:UIBarButtonItemStyleDone target:self action:@selector(setPostRequest)];
    
     UIBarButtonItem *postItem2 = [[UIBarButtonItem alloc] initWithTitle:@"post2" style:UIBarButtonItemStyleDone target:self action:@selector(setPostRequest2)];
    
    toolBar.items = @[backwardItem,forwardItem,refreshItem, backforwardListItem, getItem,postItem,postItem2];
    
}


#pragma mark -  基本介绍：前进，后退，刷新，禁止
//返回，有返回就返回，没返回就退出WKWebView
- (void)leftItemClicked:(UIButton *)sender {
    
    if ([_webView canGoBack]) {
        [_webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//前进+1
- (void)forwardButtonClicked:(UIButton *)sender {
    
    if ([_webView canGoForward]) {
        [_webView goForward];
    }
}
//后退-1
- (void)backwardButtonClicked:(UIButton *)sender {
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
}
//刷新
- (void)refreshButtonClicked:(UIButton *)sender {
    
    [_webView reload];
}

//前进后退列表
- (void)backforwardListItemClicked:(UIBarButtonItem *) sender {
    
    NSLog(@"%s", __func__);
    if (_webView.backForwardList.forwardList.count > 0) {
        NSLog(@"forwardItem");
        NSLog(@"title：%@", _webView.backForwardList.forwardItem.title);
        NSLog(@"URL：%@", _webView.backForwardList.forwardItem.URL);
    }
    if (_webView.backForwardList.backList.count > 0) {
        NSLog(@"backwardItem");
        NSLog(@"title：%@", _webView.backForwardList.backItem.title);
        NSLog(@"URL：%@", _webView.backForwardList.backItem.URL);
    }
}

//截图
- (void)snapItemClicked:(UIBarButtonItem *)sender {
    
    WKSnapshotConfiguration *snapConfig = [[WKSnapshotConfiguration alloc] init];
    [_webView takeSnapshotWithConfiguration:snapConfig completionHandler:^(UIImage * _Nullable snapshotImage, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"%@", snapshotImage);
             UIImageWriteToSavedPhotosAlbum(snapshotImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        } else {
            NSLog(@"error：%@", error);
        }
    }];
}

//简单交互
- (void)moreItemClicked:(UIBarButtonItem *)sender {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SimpleJsWithWK" bundle:nil];
    SimpleJsWithWKVC *detailVC = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSString *msg = nil;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    NSLog(@"%@", msg);
}



#pragma mark -  ✅1，WKNavigationDelegate协议的代理方法
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __func__);
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __func__);
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __func__);
      // 判断是否需要加载（仅在第一次加载）
         if (self.needLoadJSPOST) {
             // 调用使用JS发送POST请求的方法
             [self postRequestWithJS];
             // 将Flag置为NO（后面就不需要加载了）
             self.needLoadJSPOST = NO;
         };

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __func__);
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"%s", __func__);
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
   
        // ⚠️必须实现decisionHandler的回调，否则就会报错
        decisionHandler(WKNavigationResponsePolicyAllow);
        NSLog(@"WKNavigationResponsePolicyAllow");
        NSLog(@"%s", __func__);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    // ⚠️必须实现decisionHandler的回调，否则就会报错
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
//        decisionHandler(WKNavigationActionPolicyCancel);
//        NSLog(@"WKNavigationActionPolicyCancel");
//
//    } else {
//        decisionHandler(WKNavigationActionPolicyAllow);
//        NSLog(@"WKNavigationActionPolicyAllow");
//    };
//        NSLog(@"%s", __func__);
    
    NSString *_webUrlStr = navigationAction.request.URL.absoluteString;
    NSString *lastName =[[_webUrlStr lastPathComponent] lowercaseString];
        
        if ([lastName containsString:@".pdf"])
        {
            NSData *data = [NSData dataWithContentsOfURL:navigationAction.request.URL];
            NSString *urlStr = @"https://app.gjfax.com/APP_SERVER/remote/trading/getLegalAgreement?gqdm=161248&applicationId=110929";
             NSURL *url = [NSURL URLWithString:urlStr];
            [self.webView loadData:data MIMEType:@"application/octet-stream" characterEncodingName:@"UTF-8" baseURL:url];
        }
        decisionHandler(WKNavigationActionPolicyAllow);

}

#pragma mark -  ✅2，WKUIDelegate协议的代理方法
// 新建WKWebView
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
//       NSLog(@"%s", __func__);
//}

// 关闭WKWebView
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0){
       NSLog(@"%s", __func__);
}

// 对应js的Alert方法
/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
       NSLog(@"%s", __func__);
}

// 对应js的confirm方法
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
       NSLog(@"%s", __func__);
}

// 对应js的prompt方法
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
       NSLog(@"%s", __func__);
}

#pragma mark -  WKScriptMessageHandler协议
// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"%s", __func__);
}
@end
