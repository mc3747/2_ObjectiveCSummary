//
//  ZSAnalysisClass.h
//
//  Created by 张帅 on 16/7/23.
//

#import <Foundation/Foundation.h>
@interface NSObject (NSObject)
//模型转字典
- (NSDictionary *)reflectModelToDict;
//带基础数据类型
- (BOOL)mReflectDataFromOtherObject:(NSObject*)dataSource;
@end




@interface ZSAnalysisClass : NSObject
/*
 请求是否成功
 YES 为成功
*/
@property (nonatomic,assign) BOOL isOk;
/*
 请求后解析的的结果
*/
@property (nonatomic,strong) id paresData;
/**
 传入模型名（NSString ）
 返回解析后的model
 @param data data 数据对象
 @param modelClassName 模型名称
 @return ZSAnalysisClass 对象 paresData 为返回解析后的model
 */
- (ZSAnalysisClass *)parsingWithData:(id)data modelClassName:(NSString *)modelClassName;

@end




