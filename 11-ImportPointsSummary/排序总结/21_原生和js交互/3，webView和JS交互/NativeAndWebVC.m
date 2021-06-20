//
//  NativeAndWebVC.m
//  排序总结
//
//  Created by gjfax on 2019/3/21.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "NativeAndWebVC.h"
#import "UIWebViewJSViewController.h"
#import "WKWebViewJSViewController.h"

#import "JSUIWebViewViewController.h"
#import "JSWKWebViewViewController.h"

#import "JSCallOCViewController.h"
#import "OCCallJSViewController.h"
#import "HighchartsWebViewController.h"
#import "WebViewUseJsBridgeVC.h"
#import "WebViewUseJsBridge2VC.h"

@interface NativeAndWebVC ()

@end
/*
 UIWebView和WKWebview各3种方法：
 1.拦截url（适用于UIWebView和WKWebView）
 2.JavaScriptCore（只适用于UIWebView，iOS7+）
 3.WKScriptMessageHandler（只适用于WKWebView，iOS8+）
 4.WebViewJavascriptBridge（适用于UIWebView和WKWebView，属于第三方框架）

 */
@implementation NativeAndWebVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark -  UIWebview拦截url方式与js交互
- (IBAction)UIWebviewToJS:(id)sender {
    UIWebViewJSViewController *webView = [[UIWebViewJSViewController alloc]initWithNibName:@"UIWebViewJSViewController" bundle:nil];
    [self.navigationController pushViewController:webView animated:YES];
}

- (IBAction)JSToUIWebview:(id)sender {
    JSUIWebViewViewController *js = [[JSUIWebViewViewController alloc]init];
    [self.navigationController pushViewController:js animated:YES];
}

#pragma mark -  UIWebview拦截jscore方式与js交互
- (IBAction)JSCallOC:(id)sender {
    JSCallOCViewController *jsCallOC = [[JSCallOCViewController alloc]init];
    [self.navigationController pushViewController:jsCallOC animated:YES];
}

- (IBAction)OCCallJS:(id)sender {
    OCCallJSViewController *ocCallJS = [[OCCallJSViewController alloc]init];
    [self.navigationController pushViewController:ocCallJS animated:YES];
}


- (IBAction)HighchartsWeb:(id)sender {
    HighchartsWebViewController *highchartsWeb =[[HighchartsWebViewController alloc]init];
    [self.navigationController pushViewController:highchartsWeb animated:YES];
}

#pragma mark -  UIwebvie使用JSBridge
- (IBAction)webviewUseJsBridgeAction:(id)sender {
    WebViewUseJsBridgeVC *vc = [[WebViewUseJsBridgeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)WebViewUseJSBridgeAction2:(id)sender {
    WebViewUseJsBridge2VC *vc = [[WebViewUseJsBridge2VC alloc] init];
     [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  WKWebview拦截messageHandle方式与js交互
- (IBAction)WKWebViewToJS:(id)sender {
    WKWebViewJSViewController *webView = [[WKWebViewJSViewController alloc]initWithNibName:@"WKWebViewJSViewController" bundle:nil];
    [self.navigationController pushViewController:webView animated:YES];
}

- (IBAction)JSToWKWebView:(id)sender {
    JSWKWebViewViewController *js = [[JSWKWebViewViewController alloc]init];
    [self.navigationController pushViewController:js animated:YES];
}






@end
