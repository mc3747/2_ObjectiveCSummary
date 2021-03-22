//
//  ShowPDFViewController.m
//  ShowPDFDemo
//
//  Created by 张鹏 on 2017/8/28.
//  Copyright © 2017年 zhangpeng. All rights reserved.
//

#import "ShowPDFViewController.h"

#import <WebKit/WebKit.h>

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define DOCUMENTS_DIRECTORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@interface ShowPDFViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic, strong) WKWebView *webView;

@end

@implementation ShowPDFViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"查看PDF";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 将原点移动到NavigationBar下面
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setupUI];
    
    [self downloadPDF];
}

#pragma mark - Notification Methods


#pragma mark - KVO Methods

#pragma mark - Delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self loadPDF];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"]) {  //和customview.js文件交互，js调oc的代码
        
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull类型
        if ([message.body[@"code"] isEqualToString:@"00000"]) {
            
            NSLog(@"%@", message.body[@"msg"]);
        }
    }
}

#pragma mark - Target Methods


#pragma mark - Private Methods
- (void)loadPDF {
    
    NSString* path = [DOCUMENTS_DIRECTORY stringByAppendingPathComponent:@"contract.pdf"];
    
    NSData* data = [NSData dataWithContentsOfFile:path
                                          options:NSDataReadingUncached
                                            error:nil];
    
    NSString *paraStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    
    NSString *js = [NSString stringWithFormat:@"loadMyJS('%@')",paraStr];
    //NSLOG(@"%@",method);
    
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog(@"%@", error);
            
            NSLog(@"当前手机系统版本较低，不支持查看，请升级系统或者到PC端查看。");
        }
    }];
}

- (void)downloadPDF {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];

    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"从服务器获取到pdf数据");
        
        //对从服务器获取到的数据data进行相应的处理：
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString* path = [DOCUMENTS_DIRECTORY stringByAppendingPathComponent:@"contract.pdf"];
            
            NSFileManager* fm = [NSFileManager defaultManager];
            
            if ([fm fileExistsAtPath:path]) {
                
                [fm removeItemAtPath:path error:nil];
            }
            
            BOOL success =  [data writeToFile:path atomically:YES];
            
            if (success) {
                
                NSLog(@"保存成功");
                
                NSURL *baseURL = [NSURL fileURLWithPath:[self getHtmlBasePath]];
                
                NSString *path = [self getHtmlPath];

                NSString *htmlStr = [NSString stringWithContentsOfFile:path
                                                              encoding:NSUTF8StringEncoding
                                                                 error:nil];

                [self.webView loadHTMLString:htmlStr baseURL:baseURL];
            }
        });
        
    }];

    [sessionDataTask resume];
}

- (NSString*)getHtmlBasePath {
    NSString *basePath = @"";
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<9.0) {
        basePath = NSTemporaryDirectory();
    }else{
        basePath = [[NSBundle mainBundle] bundlePath];
    }
    return basePath;
}

- (NSString*)getHtmlPath{
    //在iOS8上，html及js文件的路径为temp目录下，ios9及以上则在bundle里
    NSString* path = @"";
    
    if ([[[UIDevice currentDevice]systemVersion] floatValue] < 9.0) {
        
        path = [self copyHtmlToTemp];
        
    }else{
        
        path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@".html"];
    }
    return path;
}

//在iOS8上，html及js文件要放到temp目录下才能正常访问，ios9及以上不用
- (NSString*)copyHtmlToTemp {
    
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@".html"];
    NSString* compatibilityJSPath = [[NSBundle mainBundle] pathForResource:@"compatibility" ofType:@".js"];
    NSString* customviewJSPath = [[NSBundle mainBundle] pathForResource:@"customview" ofType:@".js"];
    NSString* minimalCSSPath = [[NSBundle mainBundle] pathForResource:@"minimal" ofType:@".css"];
    NSString* pdfJSPath = [[NSBundle mainBundle] pathForResource:@"pdf" ofType:@".js"];
    NSString* pdfWorkerJSPath = [[NSBundle mainBundle] pathForResource:@"pdf.worker" ofType:@".js"];
    
    NSString* tempPath = NSTemporaryDirectory();
    
    NSString* htmlTempPath = [tempPath stringByAppendingPathComponent:@"index.html"];
    NSString* compatibilityJSTempPath = [tempPath stringByAppendingPathComponent:@"compatibility.js"];
    NSString* customviewJSTempPath = [tempPath stringByAppendingPathComponent:@"customview.js"];
    NSString* minimalCSSTempPath = [tempPath stringByAppendingPathComponent:@"minimal.css"];
    NSString* pdfJSTempPath = [tempPath stringByAppendingPathComponent:@"pdf.js"];
    NSString* pdfWorkerJSTempPath = [tempPath stringByAppendingPathComponent:@"pdf.worker.js"];
    
    NSFileManager* fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:htmlTempPath]) {
        [fm copyItemAtPath:htmlPath toPath:htmlTempPath error:nil];
    }
    if (![fm fileExistsAtPath:compatibilityJSTempPath]) {
        [fm copyItemAtPath:compatibilityJSPath toPath:compatibilityJSTempPath error:nil];
    }
    if (![fm fileExistsAtPath:customviewJSTempPath]) {
        [fm copyItemAtPath:customviewJSPath toPath:customviewJSTempPath error:nil];
    }
    if (![fm fileExistsAtPath:minimalCSSTempPath]) {
        [fm copyItemAtPath:minimalCSSPath toPath:minimalCSSTempPath error:nil];
    }
    if (![fm fileExistsAtPath:pdfJSTempPath]) {
        [fm copyItemAtPath:pdfJSPath toPath:pdfJSTempPath error:nil];
    }
    if (![fm fileExistsAtPath:pdfWorkerJSTempPath]) {
        [fm copyItemAtPath:pdfWorkerJSPath toPath:pdfWorkerJSTempPath error:nil];
    }
    
    return htmlTempPath;
}

#pragma mark - Initial Methods
- (void)setupUI {
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    WKUserContentController* wkUController = [[WKUserContentController alloc]init];
    
    config.userContentController = wkUController;
    
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    NSString *js = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:js
                                                        injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                     forMainFrameOnly:YES];
    // 添加自适应屏幕宽度js调用的方法
    [wkUController addUserScript:wkUserScript];
    
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)
                                            configuration:config];
    webView.backgroundColor = [UIColor whiteColor];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    _webView = webView;
}

#pragma mark - Setter Getter Methods


#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
