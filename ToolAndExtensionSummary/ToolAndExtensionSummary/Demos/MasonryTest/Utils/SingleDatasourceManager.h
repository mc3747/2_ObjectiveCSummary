//
//  SingleDatasourceManager.h
//  MasonryFirDemo
//
//  Created by shavekevin on 16/5/20.
//  Copyright © 2016年 shavekevin. All rights reserved.
//
/**
 *  @brief 通用单例
 *
 *  @param id 单例
 *
 *  @return self
 */
#import <Foundation/Foundation.h>

@interface SingleDatasourceManager : NSObject

+ (id)sharedDataManager;

@end
