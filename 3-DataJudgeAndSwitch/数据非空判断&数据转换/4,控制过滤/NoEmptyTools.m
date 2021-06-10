//
//  NoEmptyTools.m
//  数据排空
//
//  Created by yurong on 2017/8/23.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "NoEmptyTools.h"

@implementation NoEmptyTools

+(id)noEmptyWithObject:(id)object{
    const NSString *nullStr = @"";
    //数据处理
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [(NSArray *)object mutableCopy];
        for (int index = 0; index<array.count; index++) {
            //遍历后每个数据
            id arrayObject = array[index] ;
            //返回数据
            id useObject = [self noEmptyWithObject:arrayObject];
            //存档
            [array setObject:useObject atIndexedSubscript:index];
        }
        
        return array;
    }else if([object isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *mutableDic = [(NSDictionary *)object mutableCopy];
        for (id key in mutableDic.allKeys) {
            //遍历后每个数据
            id value = mutableDic[key];
            //返回数据
            id useObject = [self noEmptyWithObject:value];
            //存档
            [mutableDic setObject:useObject forKey:key];
        }
        
        return mutableDic;
        
    }else if([object isEqual:[NSNull null]]||object == nil){
        return nullStr;
        
    }else{
        return object;
    }
   
}



@end
