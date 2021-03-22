//
//  ClickTextView3.m
//  UIGracefulWriting
//
//  Created by gjfax on 2020/1/22.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "ClickTextView3.h"
#import "NSString+RichText.h"

#define  kCoverViewTag 111

@interface ClickTextView3()
@property (nonatomic, strong) NSMutableArray *highlightRangArray;
@property (nonatomic, strong) NSMutableArray *highlightRectArray;
@end

@implementation ClickTextView3

- (instancetype)initWithFrame:(CGRect)frame
        contentStirng:(NSString *)contentStirng
     contentAttribute:(NSDictionary<NSAttributedStringKey, id> *)contentAttribute
 highlightStringArray:(NSArray<NSString *> *)highlightStringArray
   hithlightAttribute:(NSArray<NSDictionary<NSAttributedStringKey, id> *> *)highlightAttributeArray
        highlightBgColorArray:(NSArray<UIColor *> *)highlightBgColorArray{

    if (self = [super initWithFrame:frame]) {
        self.editable = NO;        // 禁止输入，否则会弹出输入键盘
        self.scrollEnabled = NO;   // 可选的，视具体情况而定
        if (contentStirng.length > 0 && highlightStringArray.count > 0) {
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:contentStirng];
            [attStr addAttributes:contentAttribute range:NSMakeRange(0, contentStirng.length)];
            
            [highlightStringArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSRange range =  [obj rangeFrom:contentStirng];
                [attStr addAttributes:highlightAttributeArray[idx] range:range];
                [self.highlightRangArray addObject:[NSValue valueWithRange:range]];
               
            }];
            
            self.attributedText = attStr;
            [self setSelectRangeWithString:highlightStringArray color:highlightBgColorArray];
        }
    }
    return self;
}

- (void)setSelectRangeWithString:(NSArray *)highlightStringArray color:(NSArray *)highlightBgColorArray{
    [self.highlightRangArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange range = [obj rangeValue];
        //设置下划线文字的点击事件
          // self.selectedRange  影响  self.selectedTextRange
       self.selectedRange = range;
      // 获取选中范围内的矩形框
       NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
       // 清空选中范围
       self.selectedRange = NSMakeRange(0, 0);
      // 可能会点击的范围的数组
        NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
        for (UITextSelectionRect *selectionRect in selectionRects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) {
                continue;
            }
            // 将有用的信息打包<存放到字典中>存储到数组中
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            // 存储文字对应的frame，一段文字可能会有两个甚至多个frame，考虑到文字换行问题
            [dic setObject:[NSValue valueWithCGRect:rect] forKey:@"rect"];
            // 存储下划线对应的文字
            [dic setObject: highlightStringArray[idx] forKey:@"content"];
            // 存储相应的回调的block
            [dic setObject:@(idx) forKey:@"index"];
           // 存储对应的点击效果背景颜色
           [dic setValue:(UIColor *)(highlightBgColorArray[idx]) forKey:@"coverColor"];
            [selectedArray addObject:dic];
        }
        // 将可能点击的范围的数组存储到总的数组中
        [self.highlightRectArray addObject:selectedArray];
    }];
               
}

// 点击textView的 touchesBegan 方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取触摸对象
    UITouch *touch = [touches anyObject];
    // 触摸点
    CGPoint point = [touch locationInView:self];
    // 通过一个触摸点，查询点击的是不是在下划线对应的文字的frame
    NSArray *selectedArray = [self touchingSpecialWithPoint:point];
    for (NSDictionary *dic in selectedArray) {
        if(dic && dic[@"coverColor"]){
            UIView *cover = [[UIView alloc] init];
            cover.backgroundColor = dic[@"coverColor"];
            cover.frame = [dic[@"rect"] CGRectValue];
            cover.layer.cornerRadius = 5;
            cover.tag = kCoverViewTag;
            [self insertSubview:cover atIndex:0];
        }
    }
    if (selectedArray.count) {
        // 如果说有点击效果的话，加个延时，展示下点击效果,如果没有点击效果的话，直接回调
        NSDictionary *dic = [selectedArray firstObject];
        
        NSString *content = dic[@"content"];
        NSInteger idx = [dic[@"index"] integerValue];
        if (dic[@"coverColor"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.clickStringBlock) {
                    self.clickStringBlock(idx, content);
                };
            });
        }else{
            if (self.clickStringBlock) {
                self.clickStringBlock(idx, content);
            };
        }
    }
}

- (NSArray *)touchingSpecialWithPoint:(CGPoint)point
{
    // 从所有的特殊的范围中找到点击的那个点
    for (NSArray *selecedArray in self.highlightRectArray) {
        for (NSDictionary *dic in selecedArray) {
            CGRect myRect = [dic[@"rect"] CGRectValue];
            if(CGRectContainsPoint(myRect, point) ){
                return selecedArray;
            }
        }
    }
    return nil;
}
/** 点击结束的时候 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *subView in self.subviews) {
            if (subView.tag == kCoverViewTag) {
                [subView removeFromSuperview];
            }
        }
    });
}

/**
 *  取消点击的时候,清除相关的阴影
 */
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *subView in self.subviews) {
        if (subView.tag == kCoverViewTag) {
            [subView removeFromSuperview];
        }
    }
}
#pragma mark -  禁止
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
// 返回NO为禁用，YES为开启
// 粘贴
  if(action ==@selector(paste:))return NO;
// 剪切
  if(action ==@selector(cut:))return NO;
// 复制
  if(action ==@selector(copy:))return NO;
// 选择
  if(action ==@selector(select:))return NO;
// 选中全部
  if(action ==@selector(selectAll:))return NO;
// 删除
  if(action ==@selector(delete:))return NO;
// 分享
  if(action ==@selector(share))return NO;
    
  return[super canPerformAction:action withSender:sender];

}
#pragma mark -  懒加载
- (NSMutableArray *)highlightRangArray
{
    if (!_highlightRangArray) {
        _highlightRangArray = [[NSMutableArray alloc] init];
    }
    
    return _highlightRangArray;
}
- (NSMutableArray *)highlightRectArray
{
    if (!_highlightRectArray) {
        _highlightRectArray = [[NSMutableArray alloc] init];
    }
    
    return _highlightRectArray;
}
@end
