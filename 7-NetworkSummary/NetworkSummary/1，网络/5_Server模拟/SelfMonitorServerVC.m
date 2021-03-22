//
//  MonitorServerVC.m
//  NetworkSummary
//
//  Created by gjfax on 2019/5/17.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "SelfMonitorServerVC.h"
#import <PPNetworkHelper.h>
static NSString *const APIUrl = @"http://localhost:8080/MJServer/login";
@interface SelfMonitorServerVC ()

@end

@implementation SelfMonitorServerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}
#pragma mark -  get请求-无缓存
- (IBAction)simulateGet1:(id)sender {
    NSString *url = [NSString stringWithFormat:@"%@?username=%@&pwd=%@",APIUrl,@"123",@"123"];
    // 登陆
    [PPNetworkHelper POST:url parameters:nil success:^(id responseObject) {
        // 在这里你可以根据项目自定义其他一些重复操作,比如加载页面时候的等待效果, 提醒弹窗....
        NSLog(@"✅%@",[self jsonToString:responseObject]);
    } failure:^(NSError *error) {
         NSLog(@"❎%@",error);
    }];
    
   
}
#pragma mark -  get请求-有缓存
- (IBAction)simulateGet2:(id)sender {
    NSString *url = [NSString stringWithFormat:@"%@?username=%@&pwd=%@",APIUrl,@"123",@"123"];
    [PPNetworkHelper GET:url parameters:nil responseCache:^(id responseCache) {
        // 1.先加载缓存数据
           NSLog(@"❣️%@",[self jsonToString:responseCache]);
    } success:^(id responseObject) {
        // 2.再请求网络数据
          NSLog(@"✅%@",[self jsonToString:responseObject]);
    } failure:^(NSError *error) {
           NSLog(@"错误%@",error);
    }];
}
- (IBAction)simulatePost1:(id)sender {
    NSDictionary *dic = @{@"username":@"123",@"pwd":@"123"};
    [PPNetworkHelper POST:APIUrl parameters:dic success:^(id responseObject) {
        NSLog(@"✅%@",[self jsonToString:responseObject]);
    } failure:^(NSError *error) {
          NSLog(@"❎%@",error);
    }];
    
}
- (IBAction)simulatePost2:(id)sender {
    NSDictionary *dic = @{@"username":@"123",@"pwd":@"123"};
    [PPNetworkHelper POST:APIUrl parameters:dic responseCache:^(id responseCache) {
        // 1.先加载缓存数据
        NSLog(@"❣️%@",[self jsonToString:responseCache]);
    } success:^(id responseObject) {
        // 2.再请求网络数据
        NSLog(@"✅%@",[self jsonToString:responseObject]);
    } failure:^(NSError *error) {
         NSLog(@"错误%@",error);
    }];
}


/**
 *  json转字符串
 */
- (NSString *)jsonToString:(NSDictionary *)dic
{
    if(!dic){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
