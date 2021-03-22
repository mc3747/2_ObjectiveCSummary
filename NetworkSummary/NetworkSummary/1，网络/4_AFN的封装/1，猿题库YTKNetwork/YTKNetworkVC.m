//
//  YTKNetworkVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/8/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "YTKNetworkVC.h"
#import "TestBTKRequest1.h"

@interface YTKNetworkVC ()

@end

@implementation YTKNetworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testRequest];
}

- (void)testRequest {
    TestBTKRequest1 *test = [[TestBTKRequest1 alloc] init];
    [test startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSLog(@" responseJSONObject ==  \n %@",request.responseJSONObject);
        
    } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"requestOperationError == %@",request.error);
    }];
}

@end
