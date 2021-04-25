//
//  Person.h
//  day14
//
//  Created by xiaomage on 15/6/23.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    @public
    int _age;
    @protected
    double _height;
    @private
    NSString *_name;
    @package
    double _weight;
}

// 如果只有方法的实现, 没有方法的声明, 那么该方法就是私有方法
// 在OC中没有真正的私有方法, 因为OC是消息机制
//- (void)test;

@end
