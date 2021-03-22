//
//  XMGDeal.m
//  06-自定义等高cell01-storyboard
//
//  Created by xiaomage on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGDeal.h"

@implementation XMGDeal
+ (instancetype)dealWithDict:(NSDictionary *)dict
{
    XMGDeal *deal = [[self alloc] init];
    
//    deal.title = dict[@"title"];
//    deal.icon = dict[@"icon"];
//    deal.buyCount = dict[@"buyCount"];
//    deal.price = dict[@"price"];
    
    // KVC - Key Value Coding
    [deal setValuesForKeysWithDictionary:dict];
    
    return deal;
}
@end
