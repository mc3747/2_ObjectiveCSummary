//
//  ParameterClass.h
//  排序总结
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParameterClass : NSObject
@end

@interface Parameter0 : ParameterClass
@end

@interface Parameter1 : ParameterClass
@property (nonatomic, assign) int number;
@end

@interface Parameter2 : ParameterClass
@property (nonatomic, assign) int number;
@property (nonatomic, copy) NSString *age;
@end

@interface Parameter3 : ParameterClass
@property (nonatomic, assign) int height;
@property (nonatomic, copy) NSString *weight;
@end
