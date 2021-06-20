//
//  UIButton+PassValue.h
//  排序总结
//
//  Created by gjfax on 2019/12/13.
//  Copyright © 2019 macheng. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIButton (PassValue)
@property (strong ,nonatomic) NSDictionary *paramDic;
@end

NS_ASSUME_NONNULL_END
