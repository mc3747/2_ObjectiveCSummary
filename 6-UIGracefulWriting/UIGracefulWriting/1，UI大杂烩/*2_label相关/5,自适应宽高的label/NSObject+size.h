//
//  NSObject+size.h
//  LabelDemo
//
//  Created by zhuchenglong on 16/7/22.
//  Copyright © 2016年 zhuchenglong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (size)

/****自适应宽度****/
-(CGRect)getFrameWithFreeWidth:(CGPoint)origin maxHight:(CGFloat)maxHight;

/****自适应高度****/
-(CGRect)getFrameWithFreeHight:(CGPoint)origin maxWidth:(CGFloat)maxWidth;

/****自适应宽度--->可调整字间距****/
-(CGRect)getFrameWithFreeWidth:(CGPoint)origin maxHight:(CGFloat)maxHight textSpace:(CGFloat)textSpace;

/****自适应高度--->可调整字间距和行间距****/
-(CGRect)getFrameWithFreeHight:(CGPoint)origin maxWidth:(CGFloat)maxWidth textSpace:(CGFloat)textSpace lineSpace:(CGFloat)lineSpace;


@end
