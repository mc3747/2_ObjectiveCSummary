//
//  UIView+Extension.h
//  YiYunMi
//
//  Created by 李涛 on 15/4/26.
//  Copyright (c) 2015年 李涛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewClickHandle)(UIView *view);
typedef NS_ENUM(NSInteger, UIViewBorderLineType) {
    UIViewBorderLineTypeTop,
    UIViewBorderLineTypeRight,
    UIViewBorderLineTypeBottom,
    UIViewBorderLineTypeLeft,
};
@interface UIView (Extension)
//  view的x
@property (nonatomic, assign) CGFloat x;
//  view的y
@property (nonatomic, assign) CGFloat y;
//  view的top
@property CGFloat top;
//  view的bottom
@property CGFloat bottom;
//  view的中心点x
@property (nonatomic, assign) CGFloat centerX;
//  view的中心点y
@property (nonatomic, assign) CGFloat centerY;
//  view的width
@property (nonatomic, assign) CGFloat width;
//  view的height
@property (nonatomic, assign) CGFloat height;
//  view的size
@property (nonatomic, assign) CGSize size;

/**
 *  view.frame.origin
 */
@property (nonatomic, assign) CGPoint origin;
/**
 *  origin.x+width
 */
@property (nonatomic, assign) CGFloat right;
/**
 *  清空所有子view
 */
-(void)removeAllSubviews;
/**
 *  增加UIView的点击事件
 */
-(void)GJSHandleClick:(UIViewClickHandle)handle;
#pragma mark -  设置四周的边框和圆角
-(void)setViewBorderColor:(UIColor *)color radius:(float)radius border:(float)border;

#pragma mark -  设置四周的边框和圆角
-(void)setViewBorderColor:(UIColor *)color border:(float)border type:(UIViewBorderLineType)borderLineType;
@end
