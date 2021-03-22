//
//  KeyChainManager.h
//  KeyChain
//
//  Created by MAC on 2017/11/8.
//  Copyright © 2017年 NetworkCode小贱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainManager : NSObject

/*!
 保存数据

 @data  要存储的数据
 @identifier 存储数据的标示
 */
+(BOOL) keyChainSaveData:(id)data withIdentifier:(NSString*)identifier ;

/*!
 读取数据

 @identifier 存储数据的标示
 */
+(id) keyChainReadData:(NSString*)identifier ;


/*!
 更新数据

 @data  要更新的数据
 @identifier 数据存储时的标示
 */
+(BOOL)keyChainUpdata:(id)data withIdentifier:(NSString*)identifier ;

/*!
 删除数据

 @identifier 数据存储时的标示
 */
+(void) keyChainDelete:(NSString*)identifier ;

@end

