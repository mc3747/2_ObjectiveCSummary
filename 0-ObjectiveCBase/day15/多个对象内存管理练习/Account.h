//
//  Account.h
//  day15
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct{
    int year;
    int month;
    int day;
    int hour;
    int minute;
    int second;
} MyDate;
@interface Account : NSObject
//注册的时间(registerTime)
@property(nonatomic, assign)MyDate registerTime;

//账号(email)
@property(nonatomic, retain)NSString *email; // copy

//密码(pwd)
@property(nonatomic, retain)NSString *pwd;

@end
