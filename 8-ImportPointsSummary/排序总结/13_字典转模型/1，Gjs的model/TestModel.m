//
//  TestModel.m
//  字典转模型
//
//  Created by gjfax on 2017/10/30.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "TestModel.h"
#import <objc/runtime.h>

@implementation TestModel

#pragma mark - 方法1:KVC
+ (instancetype)modelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
//    /*写法1: 手写列举*/
//        _name = dict[@"name"];
//        // 字典不能保存基本数据类型，NSNumber ->
//        _age = dict[@"age"];
        
//    /*写法2: kvc列举*/
//        [self setValue:dict[@"name"] forKey:@"name"];
//        [self setValue:dict[@"age"] forKey:@"age"];
        
    /*写法3: 循环遍历字典*/
//        for (NSString *key in dict) {
//            // 1. 通过 key 取值
//            id value = dict[key];
//            // 2. 通过 KVC 方法设置数值
//            [self setValue:value forKey:key];
//        }
        
//    /*写法4: kvc直接遍历*/
//        [self setValuesForKeysWithDictionary:dict];
        
     /*写法4: kvc优化：遍历字典中的key值，去模型类里面去查找有没有所对应的key，并匹配属性的类型*/
        
          [self setClassProperty:[self class] withPropertyDic:dict];
    
    }
 
    return self;
}

- (void)setClassProperty:(Class)class withPropertyDic:(NSDictionary *)item
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        //property名称
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id valueItem = item[propertyName];
        if (valueItem) {
            //获取该property的数据类型
            const char *attries = property_getAttributes(property);
            NSString *attrString = [NSString stringWithUTF8String:attries];
            [self GJSSetPropery:attrString value:valueItem propertyName:propertyName];
        }
    }
    if(properties) free(properties);
}
- (void)GJSSetPropery:(NSString *)attriString
                value:(id)value
         propertyName:(NSString *)propertyName
{
    //kvc不支持c的数据类型，所以只能NSNumber转化，NSNumber可以  64位是TB
    if ([attriString hasPrefix:@"T@\"NSString\""]) {
        [self setValue:GJSToString(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Tc"] || [attriString hasPrefix:@"TB"]) {
        //32位Tc  64位TB
        [self setValue:[NSNumber numberWithBool:[value boolValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Ti"] || [attriString hasPrefix:@"Tq"]) {
        //32位 Ti是int 和 NSInteger  64位后，long 和  NSInteger 都是Tq， int 是Ti
        [self setValue:[NSNumber numberWithInteger:[GJSToString(value) integerValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"TQ"] || [attriString hasPrefix:@"TI"]) {
        [self setValue:[NSNumber numberWithInteger:[GJSToString(value) integerValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Tl"]) { //32位 long
        [self setValue:[NSNumber numberWithLongLong:[GJSToString(value) longLongValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Tf"]) { //float
        [self setValue:[NSNumber numberWithFloat:[GJSToString(value) floatValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Td"]) { //CGFloat
        [self setValue:[NSNumber numberWithDouble:[GJSToString(value) doubleValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSMutableArray\""]) {
        [self setValue:GJSToMutableArray(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSArray\""]) {
        [self setValue:GJSToArray(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSDictionary\""]) {
        [self setValue:GJSToDictionary(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSMutableDictionary\""]) {
        [self setValue:GJSToMutableDictionary(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSNumber\""]) {
        [self setValue:@([GJSToString(value) integerValue]) forKey:propertyName];
    }
}
/**
 *  数据校验
 */
NSString* GJSToString(id obj)
{
    return [obj isKindOfClass:[NSObject class]] ? [NSString stringWithFormat:@"%@",obj] : @"";
}

NSArray* GJSToArray(id obj)
{
    return [obj isKindOfClass:[NSArray class]] ? obj : nil;
}

NSDictionary* GJSToDictionary(id obj)
{
    return [obj isKindOfClass:[NSDictionary class]] ? obj : nil;
}

NSMutableArray* GJSToMutableArray(id obj)
{
    return [obj isKindOfClass:[NSArray class]] ||
    [obj isKindOfClass:[NSMutableArray class]] ? [NSMutableArray arrayWithArray:obj] : nil;
}

NSMutableDictionary* GJSToMutableDictionary(id obj)
{
    return [obj isKindOfClass:[NSDictionary class]] ||
    [obj isKindOfClass:[NSMutableDictionary class]] ? [NSMutableDictionary dictionaryWithDictionary:obj] : nil;
}

@end
