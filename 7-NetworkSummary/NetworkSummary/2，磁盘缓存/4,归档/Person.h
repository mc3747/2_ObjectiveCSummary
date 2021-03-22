//
//  Person.h
//  归档
//
//  Created by gjfax on 16/8/9.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *gender;
@property (assign, nonatomic) int age;
@end
