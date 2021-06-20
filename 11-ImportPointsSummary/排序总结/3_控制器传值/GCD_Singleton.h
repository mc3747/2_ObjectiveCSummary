//
//  GCD_Singleton.h
//  排序总结
//
//  Created by gjfax on 2018/6/11.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD_Singleton : NSObject
@property (nonatomic, copy) NSString *value;
+ (instancetype)sharedInstance;
@end
