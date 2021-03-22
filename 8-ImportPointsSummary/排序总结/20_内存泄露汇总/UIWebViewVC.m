//
//  UIWebViewVC.m
//  排序总结
//
//  Created by gjfax on 2019/2/15.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "UIWebViewVC.h"

@interface UIWebViewVC () <UIWebViewDelegate>
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation UIWebViewVC
- (void)dealloc
{
    NSLog(@"✅文件已经销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    NSString *url = @"http://218.17.205.130:18285/APP_SERVER/remote/product/getWDProductSpecification?fileUrl=/gjfaxb2cweb/template/gjfax/agreement/资金平台主体变更示例.pdf&title=说明书";
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *requestUrl = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:requestUrl];
    requst.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [requst setValue:@"app" forHTTPHeaderField:@"from"];
    [requst setValue:@"bridge" forHTTPHeaderField:@"version"];
    [webView loadRequest:requst];
    [self.view addSubview:webView];
    _webView = webView;
}

- (void)viewWillDisappear:(BOOL)animated {
     [super viewWillDisappear:animated];
}

#pragma mark -  代理方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}
//网页内容变化时执行
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    
    NSURLSessionDataTask *dataTask = [ [NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError *_Nullable error) {
        
        
    }];
    
    [dataTask resume];
    //  拦截错误url
    NSURL *requestURL =[request URL];
    //  由于andr打开pdf需要 格式调整为 'pdf: + url' 形式
    //  现iOS调整  拦截所有请求  遇到URL前4位为 'pdf:' 则截取掉
    NSString *specialChars = @"gjfile:";
    if ([requestURL.absoluteString hasPrefix:specialChars]) {
        //  截取特殊字符后的URL
        NSString *handledRequestURLString = [requestURL.absoluteString substringFromIndex:specialChars.length];
        
        //  new request
        NSURL *newURL = [NSURL URLWithString:handledRequestURLString];
        NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:newURL cachePolicy:request.cachePolicy timeoutInterval:request.timeoutInterval];
        
        [webView loadRequest:newRequest];
        return YES;
    }
    return YES;
}
@end
