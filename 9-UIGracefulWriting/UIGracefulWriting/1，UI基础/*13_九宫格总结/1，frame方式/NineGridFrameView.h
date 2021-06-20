//
//  NineGridFrameView.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NineGridFrameView : UIView

@property (nonatomic, copy) void(^indexPathBlock)(NSString *row,NSString *col) ;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@end

NS_ASSUME_NONNULL_END
