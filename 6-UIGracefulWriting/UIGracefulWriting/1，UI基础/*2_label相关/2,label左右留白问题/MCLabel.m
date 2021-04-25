//
//  MCLabel.m
//  UILabel
//
//  Created by gjfax on 16/8/8.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "MCLabel.h"

@implementation MCLabel

#pragma mark -  文字缩进
-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.contentInsets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.contentInsets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentInsets)];
}

#pragma mark -  设置上下留白方案1：修改行距，文字高度默认占满字体
- (CGRect )getSpaceWithLineSpace:(CGFloat )lineSpace {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpace - (self.font.lineHeight - self.font.pointSize);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    [attributes setObject:self.font forKey:NSFontAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    
     CGRect rect = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
//    用self.attributedText计算也可以
//    CGRect rect =  [self.attributedText boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    return rect;
}

#pragma mark -  上下文字留白方案2：修改文字高度，文字行距默认是0
- (CGRect )getSpaceWithLineHeight:(CGFloat )lineHeight {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    CGFloat baselineOffset = (lineHeight - self.font.lineHeight) / 4;
    [attributes setObject:@(baselineOffset) forKey:NSBaselineOffsetAttributeName];
    [attributes setObject:self.font forKey:NSFontAttributeName];
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
    
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rect;
    
}


@end
