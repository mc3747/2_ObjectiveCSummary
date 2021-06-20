//
//  THDepModelTool.m
//  TaiHealthy
//
//  Created by lujh on 2017/9/5.
//  Copyright © 2017年 taiKang. All rights reserved.
//

#import "THDepModelTool.h"
#import <objc/runtime.h>

@implementation THDepModelTool

+ (NSMutableDictionary *)sortWithDataArray:(NSArray *)dataArray andPropertyName:(nullable NSString *)name{
    // 结果字典
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:10];
    NSMutableArray *sortArray = [NSMutableArray array];
    NSMutableArray *objArray = [NSMutableArray array];
    
    if (dataArray.count <= 0) {
        NSLog(@"不能传空");
        return resultDict;
    }
    
    NSString *type;
    id obj = dataArray.firstObject;  // 判断数组内容
    if ([obj isKindOfClass:[NSString class]]) {
        // 字符串
        type = @"string";
        for (NSString *str in dataArray) {
            THDepModelTool *sortTool = [[THDepModelTool alloc]init];
            sortTool.valueStr = str;
            [objArray addObject:sortTool];
            
        }
        NSLog(@"字符串");
        
    }else{
        // 模型
        type = @"model";
        // 获取模型的属性
        unsigned int propertyCount, i;
        objc_property_t *properties = class_copyPropertyList([obj class], &propertyCount);
        for (NSObject *model in dataArray) {
            // 给自己属性赋值
            THDepModelTool *sortTool = [[THDepModelTool alloc]init];
            sortTool.model = model;
            
            for (i = 0; i < propertyCount; i++) {
                objc_property_t property = properties[i];// 获取属性
                const char *c_name = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:c_name]; // C->OC
                
                if ([propertyName isEqualToString:name]) {
                    id value = [model valueForKey:propertyName]; // 获取模型属性对应的值
                    sortTool.valueStr = value;
                    [objArray addObject:sortTool];  // 未排序, 添加到数组
                    break;
                }
                if (i == propertyCount - 1) {
                    NSLog(@"找不到属性");
                    return resultDict;
                }
            }
            
        }
        
    };
    
    sortArray = [self sortWithInitialWithArray:objArray];
    NSMutableArray *mua = [NSMutableArray array];
    NSString *firstStr;
    for (THDepModelTool *model in sortArray) {
        if ([firstStr isEqualToString:model.firstStr]) {
            if ([type isEqualToString:@"model"]) {
                [mua addObject:model.model];  // 模型扔进数组,
            }else if ([type isEqualToString:@"string"]){
                [mua addObject:model.valueStr];// 字符串扔进数组
            };
        }else{
            // 首字母不同重新初始化数组,再赋值
            firstStr = model.firstStr;
            mua = [NSMutableArray array];
            
            if ([type isEqualToString:@"model"]) {
                [mua addObject:model.model];  // 模型扔进数组,
            }else if ([type isEqualToString:@"string"]){
                [mua addObject:model.valueStr];// 字符串扔进数组
            }
            [resultDict setObject:mua forKey:firstStr]; // 给字典赋值
        }
    }
    return resultDict;
}


+ (NSArray *)getAllValuesWithFromDict:(NSDictionary *)dict{
    
    NSMutableArray *mua = [NSMutableArray array];
    
    NSArray *keys = [self sortFirstStrWithArray:dict.allKeys];
    
    for (NSString *key in keys) {
        
        NSArray *value = [dict objectForKey:key];
        [mua addObject:value];
    }
    
    return mua.copy;
    
}


+ (NSMutableArray *)sortFirstStrWithArray:(NSArray *)array{
    
    NSMutableArray *resultMua = [NSMutableArray arrayWithArray:array];
    NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]; // 升序
    [resultMua sortUsingDescriptors:[NSArray arrayWithObject:desc]];
    
    NSMutableArray *removeArray = [NSMutableArray array];
    for (NSString *first in resultMua) {
        if ([first isEqualToString:@"#"]) {
            [removeArray addObject:first];
            break;
        }
        
    }
    // 想过滤# 就先移除
    [resultMua removeObjectsInArray:removeArray];
    
    // 然后根据遍历的一个一个添加
    [resultMua addObjectsFromArray:removeArray];
    
    
    return resultMua;
    
}



+ (NSMutableArray *)sortWithInitialWithArray:(NSArray *)ary {
    //存储包含首字母和字符串的对象
    NSMutableArray *objectAry = [NSMutableArray array];
    
    //遍历的同时把首字符和对应的字符串存入到srotString对象属性中
    for (NSInteger index = 0; index < ary.count; index++) {
        THDepModelTool *sortString = ary[index];
        // 中文转英文
        sortString.bigString = [THDepModelTool transform:sortString.valueStr];
        
        if (sortString.valueStr == nil) {
            sortString.valueStr = @"";
        }
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        //得到字符串首个字符
        NSString *header = [sortString.valueStr substringToIndex:1];
        if ([predicate evaluateWithObject:header]) {
            sortString.firstStr = [header capitalizedString];
        }else{
            
            if (![sortString.valueStr isEqualToString:@""]) {
                //特殊处理的一个字
                if ([header isEqualToString:@"长"]) {
                    sortString.firstStr = @"C";
                    sortString.bigString = [sortString.bigString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"C"];
                }else{
                    
                    char initial = [sortString.bigString characterAtIndex:0];
                    if (initial >= 'A' && initial <= 'Z') {
                        sortString.firstStr = [NSString stringWithFormat:@"%c",initial];
                    }else{
                        sortString.firstStr = @"#";
                    }
                }
            }else{
                sortString.firstStr = @"#";
            }
        }
        [objectAry addObject:sortString];
    }
    //先按照首字母排序，然后对于首字母相同的再按照大写排序
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstStr" ascending:YES];
    NSSortDescriptor *descriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"bigString" ascending:YES];
    NSArray *descriptorAry = [NSArray arrayWithObjects:descriptor,descriptor2, nil];
    [objectAry sortUsingDescriptors:descriptorAry];
    
    return objectAry;
}


+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *english = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    //去除两端空格和回车 中间空格不用去，用以区分不同汉字
    [english stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [english uppercaseString];
}

@end
