//
//  ViewController.m
//  数据非空判断&数据转换
//
//  Created by gjfax on 2018/4/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 从中国天气预报网请求数据
    NSURL *url = [ NSURL URLWithString:@"http://www.weather.com.cn/adat/sk/101010100.html"];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 最简单的错误处理机制:
        if (data && !error) {
            
            // JSON格式转换成字典，IOS5中自带解析类NSJSONSerialization从response中解析出数据放到字典中
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"返回数据：%@", obj);
            NSDictionary *dict = obj[@"weatherinfo"];
            [dict setValue:[NSNull null] forKey:@"test"];
            NSDictionary *dic1 = nil;
// 测试不存在的对象，会崩溃
//             NSLog(@"测试不存在的字段:%@", dic1[@"uncity"]);
            
// 测试不存在的字段，不会崩溃
            NSLog(@"测试不存在的字段:%@", dict[@"uncity"]);
           
// 测试字段未赋值，或者服务端赋值为null的字段，会崩溃
//            NSLog(@"测试字段未赋值:%@", dict[@"test"]);
            
            
            if(dict[@"uncity"] == nil){
                NSLog(@"为nil");
                
            }else if([dict[@"uncity"] isEqual:[NSNull null]]){
                NSLog(@"为NSNull");
            }
        }
        
    }] resume];
}

#pragma mark -  1，iOS中空的种类
/*
 null是一种展示的值类型
返回为(null): if(result == nil) return;
返回为<null>: if([result isEqual:[NSNull null]]) return;
 */
/*
1，nil：空对象
2，Nil：空的类
3，NULL：c语言的空指针
4，NSNull：空的集合类
*/

#pragma mark -  2，判断后台返回的数据是否为空

#pragma mark -  3，判断是否是空字符串，空数组，空字典，空数值Number，NSValue，NSData

#pragma mark -  4，判断后台返回的json的某个字段是否为空
//该字段不存在；该字段未赋值；该字段赋值为空
//运行时判断，将空置为nil，这样不会崩溃

#pragma mark -  5，判断后台返回的字典的某个字段是否为空
//if ([data isKindOfClass:[NSDictonary class]] && [data objectForKey:@"name"]) {
//    //
//}

#pragma mark -  6，判断后台返回的模型的某个字段是否为空
//在字典转模型中，直接替换
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
//
//if (!oldValue||[oldValue isKindOfClass:[NSNull class]]) {
//
//return @"";
//
//}
//
//return oldValue;
//
//}

#pragma mark -  7，返回安全的对象，数组，字典，安全的数值，拼接值，千分位值

#pragma mark -  8，数据类型转换

@end
