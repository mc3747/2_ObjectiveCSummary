//
//  Person.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Persons : NSObject
{
    @public
    int _age;
    NSString *_name;
    double _height;
}

- (void)setAge:(int)age;
- (void)setName:(NSString *)name;
- (void)setHeight:(double)height;

- (int)age;
- (double)height;
- (NSString *)name;

@end
