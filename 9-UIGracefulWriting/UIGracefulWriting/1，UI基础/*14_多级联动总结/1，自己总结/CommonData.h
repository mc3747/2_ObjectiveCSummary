//
//  CommonData.h
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/11.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommonData : NSObject

//单例
+ (instancetype)sharedInstance;

//数据源
@property (nonatomic, strong) NSMutableArray<Province*> *threeLevelData;
@property (nonatomic, strong) NSMutableArray<Province*> *twoLevelData;
@property (nonatomic, strong) NSMutableArray<Province*> *oneLevelData;
@end

NS_ASSUME_NONNULL_END
