//
//  NSNumber+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/12.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (Category)

//字符串转NSNumber
+ (nullable NSNumber *)numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
