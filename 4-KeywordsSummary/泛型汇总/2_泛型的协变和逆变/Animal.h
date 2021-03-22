//
//  Animal.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal: NSObject

@end

@interface Pig: Animal
@property (nonatomic, assign) NSString *weight;
@end

@interface Dog: Animal
@property (nonatomic, assign) NSNumber *weight;
@end
