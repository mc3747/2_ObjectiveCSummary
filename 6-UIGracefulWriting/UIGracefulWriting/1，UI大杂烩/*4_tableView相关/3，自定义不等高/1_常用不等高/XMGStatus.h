//
//  XMGStatus.h
//  备课03-不等高的cell-非代码
//
//  Created by MJ Lee on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGStatus : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *picture;
@property (assign, nonatomic, getter=isVip) BOOL vip;

/** cell的高度 */
@property (assign, nonatomic) CGFloat cellHeight;

+ (instancetype)statusWithDict:(NSDictionary *)dict;
@end
