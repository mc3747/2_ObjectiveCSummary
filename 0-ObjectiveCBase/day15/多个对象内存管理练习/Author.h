//
//  Author.h
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface Author : NSObject
//用户昵称(name)
@property(nonatomic, retain)NSString *name;
//用户头像(icon)
@property(nonatomic, retain)NSString *icon;
//用户是否是会员(vip)
@property(nonatomic, assign, getter=isVip)BOOL vip;
//用户对应的账号(account)
@property(nonatomic, retain)Account *account;
//用户的生日(birthday)
@property(nonatomic, assign)MyDate birthday;
@end
