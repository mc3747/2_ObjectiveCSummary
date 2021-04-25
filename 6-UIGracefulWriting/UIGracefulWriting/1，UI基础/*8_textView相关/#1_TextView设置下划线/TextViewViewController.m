//
//  ViewController.m
//  SetUnderlineDemo
//
//  Created by zhangyan on 2017/5/11.
//  Copyright © 2017年 zhangyan. All rights reserved.
//

#import "TextViewViewController.h"

#define KWidth [UIScreen mainScreen].bounds.size.width

@interface TextViewViewController ()
{
    UITextView *_textView1;
    UITextView *_textView2;
}
@end

@implementation TextViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Wonderful_YelloeColor5;
    
    NSString *contentStr = @"鲸属于脊索动物门,脊椎动物亚门，哺乳纲，真兽亚纲，包含了大约98种生活在海洋、河流中的胎生哺乳动物。中国海域就有30余种。“鲸”本身定义比较模糊，鲸目可以包含所有鲸类，还有特定科的鲸类。";
    
    // 设置下划线的颜色为透明，或者不设置
    _textView1 = [self createTextViewWithTextColor:[UIColor blackColor] underLineColor:[UIColor clearColor] withText:contentStr];
    _textView1.editable = NO;
    [_textView1 sizeToFit];
    [self.view addSubview:_textView1];
    
    CGRect textView1Frame = _textView1.frame;
    textView1Frame.size.height = 350;
    _textView1.frame = textView1Frame;
    
    _textView1.layer.borderColor = [UIColor redColor].CGColor;
    _textView1.layer.borderWidth = 1;
    
    
    // 设置字儿的颜色为透明
    _textView2 = [self createTextViewWithTextColor:[UIColor clearColor] underLineColor:[UIColor blueColor] withText:contentStr];
    // 关闭交互，不然会影响_textView1的滚动或者相关事件的响应
    _textView2.userInteractionEnabled = NO;
    // 得设置最大高度，不然在_textView1滚动的时候显示不全
    [_textView2 sizeToFit];
    // 背景颜色设置为透明,不然会影响_textView1的显示
    _textView2.backgroundColor = [UIColor clearColor];
    // 一定要添加在_textView1上面，不然滚动就不能玩儿了
    [_textView1 addSubview:_textView2];
    CGRect textView2Frame = _textView2.frame;
    // 这里设置的是下划线和字儿之间的距离
    textView2Frame.origin.y = 10;
    // 因为textView的_textView1.contentInset.left的关系，得设置偏左一些，不然会对应不上
    textView2Frame.origin.x = -_textView1.contentInset.left;
    _textView2.frame = textView2Frame;
    
}


/**
 创建一个textView

 @param textColor 字体的颜色
 @param underLineColor 下划线的颜色
 @param content 显示的内容
 */
- (UITextView *)createTextViewWithTextColor:(UIColor *)textColor underLineColor:(UIColor *)underLineColor withText:(NSString *)content
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, KWidth-20, 0)];
    NSMutableAttributedString *attributedString = [self attributedStringForChat:content withColor:textColor withFontSize:[UIFont systemFontOfSize:25] withLineSpace:30 withUnderLineColor:underLineColor];
    textView.attributedText = attributedString;
    
    return textView;
}


/**
 设置富文本

 @param textString 富文本的内容
 @param color 文本的颜色
 @param font 文字的大小
 @param lineSpace 行间距
 @param underLineColor 下划线的颜色
 @return 富文本
 */
- (NSMutableAttributedString *)attributedStringForChat:(NSString *)textString withColor:(UIColor *)color withFontSize:(UIFont *)font withLineSpace:(CGFloat)lineSpace withUnderLineColor:(UIColor *)underLineColor{
    NSInteger strLength=textString.length;
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc] initWithString:textString];
    //字颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, strLength)];
    //字大小
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, strLength)];
    //行间距
    NSMutableParagraphStyle *paragraphStyle=[[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, strLength)];
    
    // 设置下划线
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 18)];
    
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleThick] range:NSMakeRange(25, 10)];
    
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleDouble] range:NSMakeRange(strLength-18, 10)];
    
    [attributedString addAttribute:NSUnderlineColorAttributeName value:underLineColor range:NSMakeRange(0, strLength)];
    
    
    return attributedString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
