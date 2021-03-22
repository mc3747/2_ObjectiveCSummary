//
//  AttributedClickableView.m
//  UIGracefulWriting
//
//  Created by gjfax on 2020/1/20.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "AttributedClickableView.h"
@interface AttributedClickableView()<UITextViewDelegate>
@property (nonatomic, weak) UIImage *selectedImage;
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, copy) NSString *content;

@end

@implementation AttributedClickableView
-(instancetype)initWithFrame:(CGRect)frame
     normalImage:(UIImage *)normalImage
  highlightImage:(UIImage *)highlightImage
    normalString:(NSString *)normalString
    highlightStringArray:(NSArray <NSString *>*)highlightStringArray
imageBlock:(ClickImageBlock)imageBlock
                 stringBlock:(ClickStringBlock)clickStringBlock{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UITextView *textView = [[UITextView alloc]initWithFrame:self.bounds];
        textView.delegate = self;
        textView.editable = NO;//必须禁止输入，否则点击将会弹出输入键盘
        textView.scrollEnabled = NO;//可选的，视具体情况而定
        [self addSubview:textView];
        _textView = textView;
    }
    return self;
}
- (void)setContent:(NSString *)content {
    _content = content;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:content];
    [attStr addAttribute:NSLinkAttributeName value:@"click://" range:NSMakeRange(6, 9)];
    [attStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]} range:NSMakeRange(6, 9)];
    _textView.attributedText = attStr;
}

#pragma mark -  代理
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    
    if ([[URL scheme] isEqualToString:@"click"]) {
        NSAttributedString *abStr = [textView.attributedText attributedSubstringFromRange:characterRange];
        if (self.clickStringBlock) {
            self.clickStringBlock(abStr.string);
        }
        return NO;
    }
    
    
    return YES;
}

@end
