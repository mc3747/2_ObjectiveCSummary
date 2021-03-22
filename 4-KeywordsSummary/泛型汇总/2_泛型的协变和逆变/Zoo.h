//
//  Zoo.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Zoo1<__covariant ObjectType>  : NSObject

/*object为通配符，可以为任何对象 */
@property (nonatomic, strong) ObjectType animal;

@end

@interface Zoo2<__contravariant ObjectType>  : NSObject

/*object为通配符，可以为任何对象 */
@property (nonatomic, strong) ObjectType animal;

@end
