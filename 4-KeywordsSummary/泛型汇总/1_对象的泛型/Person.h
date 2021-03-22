//
//  Person.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

 /*object为通配符，可以为任何对象 */
@interface Person< ObjectType> : NSObject

@property (nonatomic, strong) ObjectType language;


@end
