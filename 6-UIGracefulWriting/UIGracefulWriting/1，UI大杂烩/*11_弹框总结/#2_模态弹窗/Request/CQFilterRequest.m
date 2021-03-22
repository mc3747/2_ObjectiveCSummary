//
//  CQFilterRequest.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQFilterRequest.h"

@implementation CQFilterRequest

/** 加载大区数据 */
+ (void)loadRegionArraySuccess:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure {
    // 读取本地大区json数据，设置时间0.1秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"region_list" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        success(responseDict[@"data"][@"region_list"]);
    });
}

/** 加载部门数据 */
+ (void)loadDepartmentArraySuccess:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure {
    // 读取本地部门json数据，设置时间0.2秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"department_list" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        success(responseDict[@"data"][@"department_list"]);
    });
}

/** 加载门店数据 */
+ (void)loadHouseArraySuccess:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure {
    // 读取本地门店json数据，设置时间0.3秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"house_list" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        success(responseDict[@"data"][@"house_list"]);
    });
}

@end
