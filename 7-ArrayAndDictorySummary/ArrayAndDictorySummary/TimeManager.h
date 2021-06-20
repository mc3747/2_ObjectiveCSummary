//
//  TimeManager.h
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/1.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeManager : NSObject

+ (NSString *)getNowTimeStamp;

+ (NSString *)getimeDifferenceStar:(NSString *)time1 End:(NSString *)time2;

@end
