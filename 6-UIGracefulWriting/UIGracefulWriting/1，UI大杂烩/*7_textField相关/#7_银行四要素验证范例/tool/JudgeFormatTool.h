//
//  JudgeFormatTool.h
//  UIGracefulWriting
//
//  Created by gjfax on 2019/9/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JudgeFormatTool : NSObject
+ (BOOL)isBankCard:(NSString *)cardNo;
+ (BOOL)isUserName:(NSString *)name;
+ (BOOL)isIdentityCard:(NSString *)IDCardNumber;
+ (BOOL)isPhoneNumber:(NSString *)number;
@end

NS_ASSUME_NONNULL_END
