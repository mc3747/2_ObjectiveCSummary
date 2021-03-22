//
//  UIView+Extension.m
//  YiYunMi
//
//  Created by 李涛 on 15/4/26.
//  Copyright (c) 2015年 李涛. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

#define LINE_HEIGHT     (1/[[UIScreen mainScreen] scale])

@implementation UIView (Extension)
#pragma mark - view的x
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

#pragma mark - view的y
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

#pragma mark - top - bottom
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

#pragma mark - view的centerX
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

#pragma mark - view的centerY
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

#pragma mark - view的width
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

#pragma mark - view的height
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

#pragma mark - view的size
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}


- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)left {
    return self.origin.x;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right-frame.size.width;
    self.frame = frame;
}

- (CGFloat)right {
    return self.left + self.width;
}


- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark --  block点击回调
static char *viewClickKey;

- (void)GJSHandleClick:(UIViewClickHandle)handle {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &viewClickKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)viewClick {
    UIViewClickHandle callBack = objc_getAssociatedObject(self, &viewClickKey);
    if (callBack!= nil)
    {
        callBack(self);
    }
}

- (BOOL)isExclusiveTouch
{
    return YES;
}

@end
