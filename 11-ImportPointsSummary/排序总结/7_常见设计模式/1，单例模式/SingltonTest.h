//
//  SingltonTest.h
//  单例
//
//  Created by gjfax on 2017/2/16.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define MCSingletonH  + (instancetype)sharedInstance;

@interface SingltonTest : NSObject

@property (nonatomic, assign)   NSInteger   age;
@property (nonatomic, copy)     NSString    *name;

+ (instancetype)shareInstance;

@end
