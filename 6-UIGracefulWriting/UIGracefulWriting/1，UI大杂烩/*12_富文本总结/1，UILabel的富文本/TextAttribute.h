//
//  TextAttribute.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/8/31.
//  Copyright © 2018年 macheng. All rights reserved.
//

#ifndef TextAttribute_h
#define TextAttribute_h

/*
 Label常用方法和属性：
 - (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;//添加一个属性
 - (void)addAttributes:(NSDictionary<NSString *, id> *)attrs range:(NSRange)range;//添加一组属性
 - (void)removeAttribute:(NSString *)name range:(NSRange)range;//移除一个属性
 
 NSFontAttributeName
 字体
 NSParagraphStyleAttributeName
 段落格式
 NSForegroundColorAttributeName
 字体颜色
 NSBackgroundColorAttributeName
 背景颜色
 NSStrikethroughStyleAttributeName
 删除线格式
 NSUnderlineStyleAttributeName
 下划线格式
 NSStrokeColorAttributeName
 删除线颜色
 NSStrokeWidthAttributeName
 删除线宽度
 NSShadowAttributeName
 阴影
 */

#pragma mark - 字体大小
/*NSFontAttributeName：[UIFont systemFontOfSize:16.0] */

#pragma mark - 字间距
/*NSKernAttributeName：@10 */

#pragma mark - 最大宽度
/*
 - (CGSize)sizeOfAttributedString: (NSAttributedString *)string withMaxWidth: (CGFloat)maxWidth
 {
 CGRect rect = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
 return rect.size;
 }
 */

#pragma mark - 换行格式
#pragma mark - 行间距
/*
 NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 [paragraphStyle setAlignment:NSTextAlignmentLeft];
 [paragraphStyle setLineSpacing:lineSpacing];
 [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
 [contentString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentString length])];
 */

#pragma mark - 调整文字字体适应label宽度
/*
 adjustsFontSizeToFitWidth
 */


#pragma mark - 调整文字间距适应label宽度
/*
 adjustsLetterSpacingToFitWidth
 */


#pragma mark - 调整label宽度适应字体和间距
/*
 sizeToFit：根据内容调整控件宽度
 */
#endif /* TextAttribute_h */
