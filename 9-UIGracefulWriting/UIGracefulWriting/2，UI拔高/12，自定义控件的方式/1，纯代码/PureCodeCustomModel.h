//
//  CustomModel.h
//  自定义控件
//
//  Created by gjfax on 16/6/3.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PureCodeCustomModel : NSObject
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *labelName;

- (instancetype)initWithlabel:(NSString *)labelName andImage:(NSString *)imageName;
+ (instancetype)modelWithlabel:(NSString *)labelName andImage:(NSString *)imageName;
@end
