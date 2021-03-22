//
//  CommonUnderlineButton.m
//  GjFax
//
//  Created by gjfax on 2018/4/13.
//  Copyright © 2018年 GjFax. All rights reserved.
//

#import "CommonUnderlineButton.h"
#import "UIView+Extension.h"


@interface CommonUnderlineButton()
@property (nonatomic, assign) BOOL isHighLightClick;
@end
@implementation CommonUnderlineButton

#pragma mark -  自定义初始化方法
- (instancetype)initWithButtonFrame:(CGRect)frame
                textNormalColor:(UIColor *)textNormalColor
             textHighlightColor:(UIColor *)textHighlightColor
                lineNormalColor:(UIColor *)lineNormalColor
             lineHighlightColor:(UIColor *)lineHighlightColor
                  underDistance:(CGFloat)underDistance
                     clickBlock:(UnderlineButtonClickBlock)clickBlock {
    
    if (self = [self  initWithFrame:frame]) {
        [self setTitleColor:textNormalColor forState:UIControlStateNormal];
        [self setTitleColor:textHighlightColor forState:UIControlStateHighlighted];
        _lineNormalColor = lineNormalColor;
        _lineHighlightColor = lineHighlightColor;
        _underDistance = underDistance;
        _clickBlock = clickBlock;
         self.isHighLightClick = NO;
        [self setNeedsDisplay];
       
    };
    
    return self;
    
}
#pragma mark -  初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + 3);
        [self addTargetAction];
    }
    return self;
}

#pragma mark -  下划线
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.top = 0;
    self.titleLabel.centerY = (self.height - 3) * 0.5;
    [self.titleLabel sizeToFit];
}
#pragma mark -  监听事件
- (void)addTargetAction {
    
    [self addTarget:self action:@selector(buttonDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -  按下
-(void)buttonDown:(id)sender{
     self.isHighLightClick = YES;
    [self setNeedsDisplay];
}
#pragma mark -  抬起
-(void)buttonClicked:(id)sender{
    self.isHighLightClick = NO;
    if (self.clickBlock) {
        self.clickBlock(sender);
    }
    [self setNeedsDisplay];
}


#pragma mark -  下划线距离
- (void)setUnderDistance:(CGFloat)underDistance {
    _underDistance = underDistance;
    self.isHighLightClick = NO;
    [self setNeedsDisplay];
    
}
#pragma mark -  下划线颜色
- (void)setLineNormalColor:(UIColor *)lineNormalColor {
    _lineNormalColor = lineNormalColor;
    self.isHighLightClick = NO;
    [self setNeedsDisplay];
}

#pragma mark -  重绘
- (void) drawRect:(CGRect)rect {
    CGRect textRect = self.titleLabel.frame;
    CGFloat descender = self.titleLabel.font.descender;
    CGContextClearRect(UIGraphicsGetCurrentContext(), rect);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
   
    //下划线颜色
    UIColor *lineColor;
    if (_isHighLightClick) {
        if (_lineHighlightColor && [_lineHighlightColor isKindOfClass:[UIColor class]]) {
            lineColor = _lineHighlightColor;
        } else {
            lineColor = [UIColor clearColor];
        };
    }else {
        if (_lineNormalColor && [_lineNormalColor isKindOfClass:[UIColor class]]) {
            lineColor = _lineNormalColor;
        } else {
            lineColor = [UIColor clearColor];
        };
    }
   
    CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
    
    //下划线距离
    CGFloat underDistance = _underDistance?_underDistance:2.f;
    //线条粗细
    CGContextSetLineWidth(contextRef,0.5);
    //开始绘图
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + underDistance);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + underDistance);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}



@end
