//
//  Person.m
//  归档
//
//  Created by gjfax on 16/8/9.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "Person.h"

@implementation Person

//实现NSCoding协议中的归档方法
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeInt:self.age forKey:@"age"];
}

//实现NSCoding协议中的解档方法
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.age = [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}
@end
