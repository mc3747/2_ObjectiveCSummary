//
//  ZWJModel.h
//  12-掌握-多图下载综合案例
//
//  Created by 赵文娟 on 17/2/23.
//  Copyright © 2017年 ZWJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWJModel : NSObject
/** APP的名称 */
@property (nonatomic, strong) NSString *name;
/** APP的图片的url地址 */
@property (nonatomic, strong) NSString *icon;
/** APP的下载量 */
@property (nonatomic, strong) NSString *download;

//初始化model   dic——》model
+(instancetype)arrMWithDic:(NSDictionary *)dic;
@end
