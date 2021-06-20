//
//  ZSAnalysisClass.m
//
//  Created by 张帅 on 16/7/23.


#import "ZSAnalysisClass.h"
#import <objc/runtime.h>

@implementation NSObject (NSObject)
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
///获取模型属性数组
- (NSArray*)propertyKeys{
    unsigned int outCount, i;
    objc_property_t *properties;
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    
    properties = class_copyPropertyList(self.superclass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}

- (NSArray *)selfPropertyKeys{
    unsigned int outCount, i;
    objc_property_t *properties;
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}
//模型转字典
- (NSDictionary *)reflectModelToDict{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    for (NSString *key in [self selfPropertyKeys]) {
        Class tempClass=NSClassFromString(key);
        NSObject *value=[self valueForKey:key];
        if (!value) {
            continue;
        }
        if (tempClass) {
            if ([value isKindOfClass:[NSArray class]]) {
                NSArray *array=(NSArray *)value;
                if (array.count<=0) {
                    continue;
                }else{
                    NSMutableArray *brray=[[NSMutableArray alloc]init];
                    for (id obj in array) {
                        NSDictionary *dict=[obj reflectModelToDict];
                        [brray addObject:dict];
                    }
                    [params setObject:brray forKey:key];
                }
            }else{
                NSDictionary *dict=[value reflectModelToDict];
                [params setObject:dict forKey:key];
            }
        }else{
            [params setObject:value forKey:key];
        }
    }
    return params;
}

//带基础数据类型
- (BOOL)mReflectDataFromOtherObject:(NSObject*)dataSource{
    BOOL ret = NO;
    NSArray * array = [self propertyKeys];
    for (NSString *key in array) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        } else {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                if ([propertyValue isKindOfClass:[NSArray class]]) {
                    NSMutableArray *array=[NSMutableArray array];
                    for (NSDictionary *dict in propertyValue) {
                        Class tempClass=NSClassFromString(key);
                        if (tempClass) {
                            NSObject *obj=[[tempClass alloc]init];
                            [obj mReflectDataFromOtherObject:dict];
                            [array addObject:obj];
                        }else{
                            [array addObject:dict];
                        }
                    }
                    [self setValue:array forKey:key];
                }else if ([propertyValue isKindOfClass:[NSDictionary class]]){
                    Class tempClass=NSClassFromString(key);
                    if (tempClass) {
                        NSObject *obj=[[tempClass alloc]init];
                        [obj mReflectDataFromOtherObject:propertyValue];
                        [self setValue:obj forKey:key];
                    }else{
                        [self setValue:propertyValue forKey:key];
                    }
                }else{
                    if (![key isEqualToString:@"imageData"]) {
                        [self setValue:propertyValue forKey:key];
                    }
                }
            }else{
                [self setValue:@"" forKey:key];
            }
        }
    }
    return ret;
}

@end


@implementation ZSAnalysisClass
- (instancetype)init {
    self=[super init];
    if (self) {
        
    }
    return self;
}
- (ZSAnalysisClass *)parsingWithData:(id)data modelClassName:(NSString *)modelClassName {
    NSDictionary * resultDict;
    if ([data isKindOfClass:[NSData class]]) {
        NSString *stringValue=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        resultDict =[self getObjectFromJsonString:stringValue];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        resultDict=(NSDictionary *)data;
    } else {
        resultDict=nil;
    }

    if (resultDict==nil && [resultDict isEqual:[NSNull class]]) {
        self.isOk=NO;
        self.paresData=@"无数据";
        return self;
    }
  @try {
    if (modelClassName && [resultDict isKindOfClass:[NSDictionary class]]) {
        Class tempClass=NSClassFromString(modelClassName);
        NSObject *obj=[[tempClass alloc]init];
        [obj mReflectDataFromOtherObject:resultDict];
        self.isOk=YES;
        self.paresData=obj;
        return self;
    } else {
        return self;
    }
  }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
   
}

-(id)getObjectFromJsonString:(NSString *)jsonString{
    NSError *error=nil;
    if (jsonString) {
        id result=[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        if (error==nil) {
            return result;
        }
        else{
            return nil;
        }
    }
    return nil;
}
@end
    
    
    
    
    
    
    
    

