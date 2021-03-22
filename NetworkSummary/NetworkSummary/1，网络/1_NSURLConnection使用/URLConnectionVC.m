//
//  URLConnectionVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/8/29.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "URLConnectionVC.h"

@interface URLConnectionVC ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end

@implementation URLConnectionVC
// 可以使用http请求的设置：info/最简单的解决方案：
// 1，在info.plist文件中添加App Transport Security Settings 类型是一个Dictionary
// 2，在App Transport Security Settings下添加Allow Arbitrary Loads 类型Boolean,值设为YES

/**
 ios 网络编程
 在iOS下进行网络编程主要分为以下三步
 1。客户端向服务器发送请求，请求方式有两种：一种get请求，一种post请求
 get请求是将信息直接拼接在URL后面，在真正开发中用到比较多
 post请求是将一些比较重要的信息转化为二进制流。在真正开发中post请求常见于验证用户名密码是否正确，给服务器上传数据等
 注意不管是get请求还是post请求都是由后台决定的，程序员可以通过接口文档知道当前的请求方式是get还是post
 请求方式不仅仅仅限于get和post，还有delete和put等，除了get请求可以使用NSUrlRequest之外，其他请求必须使用NSMutableURLRequset，明确的指定当前的HTTPMethod是什么请求。
 2.和服务器建立连接
 3.服务器做出响应
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSURLConnection的使用";
    [self.button1 addTarget:self action:@selector(get) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -  get请求
- (void)get {
        // 1.URL
        NSURL *url = [NSURL URLWithString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213"];
    
        // 2.封装请求
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10];
    
        // 3.发送请求
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        // 错误信息
        if(error)
        {
            NSLog(@"%@", [error localizedDescription]);
        }
    
        NSError *newError = nil;
        // 下面的方法有3个参数，参数分别为NSURLRequest，NSURLResponse**，NSError**，后面两个参数之所以传地址进来是为了在执行该方法的时候在方法的内部修改参数的值。这种方法相当于让一个方法有了多个返回值
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&newError];
    
    
        NSArray *array = dictionary[@"news"];
        NSDictionary *dic = array[0];
        NSLog(@"%@", dic[@"title"]);
    [CommonMethod showTextViewAlert:dic[@"title"]];
}

#pragma mark -  post请求
- (void)post {
    // 1.获取请求网址
    NSURL *url = [NSURL URLWithString:@"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx?"];
    
    // 2.封装请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];  // post
    
    // 设置请求方式
    [request setHTTPMethod:@"POST"];
    
    // 设置请求体(会把请求的数据转成data,达到用户信息保密的目的)
    NSData *data = [@"date=20131129&startRecord=1&len=5&udid=1234567890&terminalType=Iphone&cid=213" dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:data];
    
    // 3。发送请求
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *content = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSError *newError = nil;
    // 获取数据
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingMutableContainers error:&newError];
    
    
    NSArray *array = dict[@"news"];
    NSDictionary *dic = array[0];
    NSLog(@"%@", dic[@"title"]);
    [CommonMethod showTextViewAlert:dic[@"title"]];
}
@end
