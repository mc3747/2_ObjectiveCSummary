//
//  XMGDeal.h
//  06-自定义等高cell01-storyboard
//
//  Created by xiaomage on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGDeal : NSObject
@property (strong, nonatomic) NSString *buyCount;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *icon;

+ (instancetype)dealWithDict:(NSDictionary *)dict;
@end
