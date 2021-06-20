//
//  ReturnValueManager.m
//  排序总结
//
//  Created by gjfax on 2018/6/6.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ReturnValueManager.h"

@implementation ReturnValueManager
 /*1,返回字典 */
+ (NSDictionary *)returnMoreResult1:(NSString *)inputString {
    NSString *appendString1 = [NSString stringWithFormat:@"拼接结果1:%@",inputString];
    NSString *appendString2 = [NSString stringWithFormat:@"拼接结果2:%@",inputString];
    NSDictionary *dic = @{@"key1":appendString1,@"key2":appendString2};
    return dic;
}

/*2，传入指针 */
+ (void)returnMoreResult2:(NSString *)inputString
            returnString1:(NSString **)returnString1
            returnString2:(NSString **)returnString2 {
    NSString *appendString1 = [NSString stringWithFormat:@"拼接结果1:%@",inputString];
    NSString *appendString2 = [NSString stringWithFormat:@"拼接结果2:%@",inputString];
    *returnString1 = appendString1;
    *returnString2 = appendString2;
}

/*3，返回block */
+(void)returnMoreResult3:(NSString *)inputString Block:(ReturnResultBlock)block {
    NSString *appendString1 = [NSString stringWithFormat:@"拼接结果1:%@",inputString];
    NSString *appendString2 = [NSString stringWithFormat:@"拼接结果2:%@",inputString];
    block(appendString1,appendString2);
}
@end
