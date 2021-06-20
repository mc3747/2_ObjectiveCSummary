//
//  Goods.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Color.h"
@interface Goods<ObjectType> : NSObject

@property (nonatomic, strong) ObjectType color;

+ (instancetype)getColor1;

+ (__kindof Color*)getColor2;
@end
