//
//  CQFilterRequest.h
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CQFilterRequest : NSObject

/** 加载大区数据 */
+ (void)loadRegionArraySuccess:(void (^)(NSArray *regionArray))success failure:(void (^)(NSString *errorMessage))failure;

/** 加载部门数据 */
+ (void)loadDepartmentArraySuccess:(void (^)(NSArray *departmentArray))success failure:(void (^)(NSString *errorMessage))failure;

/** 加载门店数据 */
+ (void)loadHouseArraySuccess:(void (^)(NSArray *houseArray))success failure:(void (^)(NSString *errorMessage))failure;

@end
