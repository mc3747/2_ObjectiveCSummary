//
//  ReturnValueManager.h
//  排序总结
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReturnResultBlock) (NSString *returnString1,NSString *returnString2);
@interface ReturnValueManager : NSObject

 /*1,返回字典 */
+ (NSDictionary *)returnMoreResult1:(NSString *)inputString;

 /*2，传入指针 */
+ (void)returnMoreResult2:(NSString *)inputString
            returnString1:(NSString **)returnString1
            returnString2:(NSString **)returnString2;

 /*3，返回block */
+(void)returnMoreResult3:(NSString *)inputString Block:(ReturnResultBlock)block;
@end
