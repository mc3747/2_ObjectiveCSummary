//
//  ClassManager.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassManager : NSObject
/*
 @class:
 1,如果两个类相互拷贝, 例如A拷贝B, B拷贝A, 这样会报错
 2,如何解决: 在.h中用@class, 在.m中用import
    因为如果.h中都用import, 那么A拷贝B, B又拷贝A, 会形成死循环
    如果在.h中用@class, 那么不会做任何拷贝操作, 而在.m中用import只会拷贝对应的文件, 并不会形成死循环
 */
@end
