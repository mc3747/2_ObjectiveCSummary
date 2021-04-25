//
//  AttributedClickableLabelVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2020/1/20.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "AttributedClickableLabelVC.h"
#import "AttributedClickableView.h"

#define font 17
@interface AttributedClickableLabelVC ()<UITextViewDelegate>
@property (strong, nonatomic)  UITextView *textview;
@property (assign, nonatomic) BOOL isSelect;
@end

@implementation AttributedClickableLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    AttributedClickableView*label = [[AttributedClickableView alloc]initWithFrame:CGRectMake(10, 100, 300, 60)];
//    label.content = @"您将同意《 巴拉巴拉小魔仙协议 》";
//    label.clickBlock = ^(NSString * _Nonnull string) {
//        NSLog(@"%@",string);
//    };
//    [self.view addSubview:label];
    self.textview = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    self.textview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textview];
    [self protocolIsSelect:self.isSelect];
}

- (void)protocolIsSelect:(BOOL)select {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请遵守以下协议《支付宝协议》《微信协议》《建行协议》《招行协议》《中国银行协议》《上海银行协议》"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"zhifubao://"
                             range:[[attributedString string] rangeOfString:@"《支付宝协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"weixin://"
                             range:[[attributedString string] rangeOfString:@"《微信协议》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"jianhang://"
                             range:[[attributedString string] rangeOfString:@"《建行协议》"]];
 

    UIImage *image = [UIImage imageNamed:select == YES ? @"new_feature_share_true" : @"new_feature_share_false"];
    CGSize size = CGSizeMake(font + 2, font + 2);
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [image drawInRect:CGRectMake(0, 2, size.width, size.height)];
    UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = resizeImage;
    NSMutableAttributedString *imageString = [NSMutableAttributedString attributedStringWithAttachment:textAttachment];
    [imageString addAttribute:NSLinkAttributeName
                             value:@"checkbox://"
                             range:NSMakeRange(0, imageString.length)];
    [attributedString insertAttributedString:imageString atIndex:0];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, attributedString.length)];
    _textview.attributedText = attributedString;
    _textview.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                     NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                     NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};
    
    _textview.delegate = self;
    _textview.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
    _textview.scrollEnabled = NO;
//    _textview.selectable = NO;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"jianhang"]) {
        NSLog(@"建行支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"zhifubao"]) {
        NSLog(@"支付宝支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"weixin"]) {
       NSLog(@"微信支付---------------");
        return NO;
    } else if ([[URL scheme] isEqualToString:@"checkbox"]) {
        self.isSelect = !self.isSelect;
        [self protocolIsSelect:self.isSelect];
        return NO;
    }
    return YES;
}


@end
