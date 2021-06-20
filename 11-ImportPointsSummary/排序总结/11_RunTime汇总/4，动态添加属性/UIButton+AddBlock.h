//
//  UIButton+AddBlock.h
//  排序总结
//
//  Created by gjfax on 2020/3/16.
//  Copyright © 2020 macheng. All rights reserved.
//



#import <UIKit/UIKit.h>
// =====================================================
/*
 为button添加一个点击block属性
 */
// =====================================================
typedef void (^btnBlock)(id sender);

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (AddBlock)


- (void)handelWithBlock:(btnBlock)block;

@end

NS_ASSUME_NONNULL_END
