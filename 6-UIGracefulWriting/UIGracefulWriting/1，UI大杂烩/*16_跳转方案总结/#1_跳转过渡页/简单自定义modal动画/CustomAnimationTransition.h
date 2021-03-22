//
//  CustomAnimationTransition.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/11/23.
//  Copyright © 2018 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAnimationTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign,nonatomic)BOOL presented;

@end

NS_ASSUME_NONNULL_END
