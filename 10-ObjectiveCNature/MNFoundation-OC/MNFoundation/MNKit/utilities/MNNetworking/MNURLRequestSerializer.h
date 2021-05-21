//
//  MNURLRequestSerializer.h
//  MNKit
//
//  Created by Vincent on 2018/11/6.
//  Copyright © 2018年 小斯. All rights reserved.
//  请求序列化器

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const MNURLRequestUploadBoundaryName;

typedef NSString * (^MNQueryStringSerializationCallback)(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error);

@interface MNURLRequestSerializer : NSObject

NSString * MNQueryStringFromParameters (NSDictionary *parameters, NSString *split);

/**是否允许蜂窝网络访问*/
@property (nonatomic) BOOL allowsCellularAccess;
/**超时时间*/
@property (nonatomic) NSTimeInterval timeoutInterval;
/**编码格式*/
@property (nonatomic) NSStringEncoding stringEncoding;
/**缓存策略*/
@property (nonatomic) NSURLRequestCachePolicy cachePolicy;
/**请求体参数*/
@property (nonatomic, copy) NSDictionary <NSString *, NSString *>*headerFields;
/**序列化回调*/
@property (nonatomic, copy) MNQueryStringSerializationCallback queryStringSerializationCallback;

/**
 实例化入口
 @return 请求序列化器
 */
+ (instancetype)serializer;

/**
 数据请求序列化入口
 @param method 请求方式
 @param url 请求地址
 @param parameter 请求参数
 @param error 错误信息
 @return 可变请求体
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                       url:(NSString *)url
                                parameter:(NSDictionary *)parameter
                                     error:(NSError *__autoreleasing *)error;

/**
 数据上传序列化入口
 @param url 上传地址
 @param parameter 参数
 @param error 错误信息
 @return 可变请求体
 */
- (NSMutableURLRequest *)uploadRequestWithUrl:(NSString *)url
                                    parameter:(NSDictionary *)parameter
                                        error:(NSError *__autoreleasing *)error;

/**
 请求认证
 @param username 用户名
 @param password 密码
 */
- (void)setAuthorizationHeaderFieldWithUsername:(NSString *)username password:(NSString *)password;

@end

