//
//  MNURLUploadRequest.h
//  MNKit
//
//  Created by Vincent on 2018/11/18.
//  Copyright © 2018年 小斯. All rights reserved.
//  上传请求

#import "MNURLRequest.h"

typedef void(^MNURLRequestUploadBodyCallback)(NSURL **URL, NSData **body);

@interface MNURLUploadRequest : MNURLRequest

/**
 上传实例
 */
@property (nonatomic, readonly) NSURLSessionUploadTask *uploadTask;

/**
 上传的数据
 */
@property (nonatomic, copy) MNURLRequestUploadBodyCallback bodyCallback;


/**
 开启上传请求
 @param startCallback 请求开始回调
 @param bodyCallback 上传内容回调
 @param progressCallback 进度回调
 @param finishCallback 请求结束回调
 */
- (void)uploadData:(MNURLRequestStartCallback)startCallback
          body:(MNURLRequestUploadBodyCallback)bodyCallback
          progress:(MNURLRequestProgressCallback)progressCallback
        completion:(MNURLRequestFinishCallback)finishCallback;

@end

