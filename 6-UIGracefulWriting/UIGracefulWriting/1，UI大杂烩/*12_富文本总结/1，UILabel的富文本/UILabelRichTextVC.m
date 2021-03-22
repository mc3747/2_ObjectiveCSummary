//
//  UILabelRichTextVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/8/31.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "UILabelRichTextVC.h"

@interface UILabelRichTextVC ()

@end

@implementation UILabelRichTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 50)];
    label1.attributedText = [self returenAttributedString1];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 300, 50)];
    label2.attributedText = [self returenAttributedString2];
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 240, 300, 50)];
    label3.attributedText = [self returenAttributedString3];
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 300, 300)];
    label4.numberOfLines = 0;
    label4.lineBreakMode = NSLineBreakByCharWrapping;
    label4.attributedText = [self showHtml];
    [self.view addSubview:label4];
}

#pragma mark - 富文本的创建方法1：逐个添加富文本对象的属性
- (NSMutableAttributedString *)returenAttributedString1 {
    //初始化富文本对象：
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:@"1，我们都有一个家名字叫中国"];
    //给富文本添加属性1-字体大小
    [attributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:16.0]
                          range:NSMakeRange(2, 2)];
    //给富文本添加属性1-字间距
    [attributedStr addAttribute:NSKernAttributeName
                          value:@10
                          range:NSMakeRange(2, 2)];
    
    //给富文本添加属性3-字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:NSMakeRange(2, 2)];
    //给富文本添加属性4-下划线
    [attributedStr addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:NSMakeRange(2, 2)];
    return attributedStr;
};

#pragma mark - 富文本的创建方法2：创建富文本对象后统一设置富文本对象的属性
- (NSMutableAttributedString *)returenAttributedString2 {
    //初始化富文本对象
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:@"2，我们都有一个家名字叫中国"];
    //富文本的属性通过字典的形式传入
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:16.0],NSFontAttributeName,//字体
                                   [UIColor redColor],NSForegroundColorAttributeName,//字体颜色
                                   [UIColor greenColor],NSBackgroundColorAttributeName,//字体背景色
                                   @(NSUnderlineStyleSingle),NSUnderlineStyleAttributeName,//下划线
                                   @(NSUnderlineStyleSingle),NSStrikethroughStyleAttributeName,//删除线
                                   [UIColor blueColor],NSUnderlineColorAttributeName,//下划线颜色
                                   [UIColor yellowColor],NSStrikethroughColorAttributeName,//删除线颜色
                                   [NSURL URLWithString:@"http://www.baidu.com"],NSLinkAttributeName,
                                   nil];
    //统一设置富文本对象的属性
    [attributedStr addAttributes:attributeDict range:NSMakeRange(2, 2)];
    //或者也可以使用下面的方法
    [attributedStr setAttributes:attributeDict range:NSMakeRange(4, 2)];
    return attributedStr;
};

#pragma mark - 富文本的创建方法3：创建富文本对象的同时就添加属性
- (NSMutableAttributedString *)returenAttributedString3 {
    NSString *textString = @"3，我们都有一个家名字叫中国";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
       [paragraphStyle setAlignment:NSTextAlignmentLeft];
       [paragraphStyle setLineSpacing:5];
       [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    //富文本的属性通过字典的形式传入
    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:16.0],NSFontAttributeName,//字体大小
                                   [UIColor redColor],NSForegroundColorAttributeName,//字体颜色
                                   @(NSUnderlineStyleSingle),NSUnderlineStyleAttributeName,//下划线
                                   
                                        @5,NSKernAttributeName,//字间距
                                   paragraphStyle,NSParagraphStyleAttributeName,//行间距
                                   nil];
    //初始化富文本对象的同时设置富文本对象的属性
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc]initWithString:textString attributes:attributeDict];
    return attributedStr;
};

#pragma mark -  富文本的创建：html格式
//只能做一些展示文字大小，颜色
- (NSMutableAttributedString *)showHtml {
    NSString * htmlString = @"<html><body> <font size=\"8\" color=\"blue\">4，我们都有一个家名字叫</a> <a></font> <font size=\"13\" color=\"red\">中国!</font></a> </body></html>";
    
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}
@end
