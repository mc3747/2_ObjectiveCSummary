//
//  ClickTextView1.m
//  UIGracefulWriting
//
//  Created by gjfax on 2020/1/22.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "ClickTextView1.h"
#import "NSString+RichText.h"

@interface ClickTextView1()<UITextViewDelegate>

@end
@implementation ClickTextView1

- (instancetype)initWithFrame:(CGRect)frame
       contentStirng:(NSString *)contentStirng
    contentAttribute:(NSDictionary<NSAttributedStringKey, id> *)contentAttribute
highlightStringArray:(NSArray<NSString *> *)highlightStringArray
  hithlightAttribute:(NSArray<NSDictionary<NSAttributedStringKey, id> *> *)highlightAttributeArray{

        if (self = [super initWithFrame:frame]) {
            self.delegate = self;
            self.editable = NO;        // 禁止输入，否则会弹出输入键盘
            self.scrollEnabled = NO;   // 可选的，视具体情况而定
            if (contentStirng.length > 0 && highlightStringArray.count > 0) {
                
                NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:contentStirng];
                [attStr addAttributes:contentAttribute range:NSMakeRange(0, contentStirng.length)];
                
                [highlightStringArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    NSString *urlIndex = [NSString stringWithFormat:@"Click%lu://",(unsigned long)idx];
                                    NSRange range =  [obj rangeFrom:contentStirng];
                                    [attStr addAttributes:highlightAttributeArray[idx] range:range];
                                    [attStr addAttribute:NSLinkAttributeName value:urlIndex range:range];
                }];
                
                self.attributedText = attStr;
                
            }
        }
     return self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{

    NSString *urlScheme  =  [URL scheme];
    NSAttributedString *abStr = [textView.attributedText attributedSubstringFromRange:characterRange];

    if (urlScheme.length > 0 && abStr.string.length > 0) {
        NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSString *indexString = [[urlScheme componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
       NSInteger indexInt = [indexString integerValue];
        if (self.clickStringBlock) {
                self.clickStringBlock(indexInt,abStr.string);
        };
         return NO;
      }

    return YES;
}
@end
