//
//  UIView+Category.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2019/3/20.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewClickHandle)(UIView *view);
typedef NS_ENUM(NSInteger, UIViewBorderLineType) {
    UIViewBorderLineTypeTop,
    UIViewBorderLineTypeRight,
    UIViewBorderLineTypeBottom,
    UIViewBorderLineTypeLeft,
};
NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)

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
// view.frame.origin
@property (nonatomic, assign) CGPoint origin;
// origin.x+width
@property (nonatomic, assign) CGFloat right;


#pragma mark -   清空所有子view
-(void)removeAllSubviews;

#pragma mark -  增加UIView的点击事件

-(void)GJSHandleClick:(UIViewClickHandle)handle;

#pragma mark -  设置四周的边框和圆角
-(void)setViewBorderColor:(UIColor *)color radius:(float)radius border:(float)border;

#pragma mark -  设置四周的边框和圆角
-(void)setViewBorderColor:(UIColor *)color border:(float)border type:(UIViewBorderLineType)borderLineType;

@end

NS_ASSUME_NONNULL_END
