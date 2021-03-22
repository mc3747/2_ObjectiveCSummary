//
//  MCLabel.h
//  UILabel
//
//  Created by gjfax on 16/8/8.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MCLabel : UILabel

// 文字上左下右的缩进值：更改缩进值后，还要更改frame，不建议
@property (assign, nonatomic) UIEdgeInsets contentInsets;

//调整留白：修改行距，文字高度默认占满字体（文字顶上和顶下）
- (CGRect )getSpaceWithLineSpace:(CGFloat )lineSpace;

//调整留白：修改文字高度，文字行距默认是0（文字居中）
- (CGRect )getSpaceWithLineHeight:(CGFloat )lineHeight;
@end
