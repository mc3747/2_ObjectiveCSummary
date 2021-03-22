//
//  TextViewRichVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/2/20.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "TextViewRichVC.h"
#import "ClickTextView1.h"
#import "ClickTextView2.h"
#import "ClickTextView3.h"

static const NSInteger textFont = 17;

@interface TextViewRichVC ()<UITextViewDelegate>
@property (weak, nonatomic)  UITextView *textview;
@property (assign, nonatomic) BOOL isSelect;
@property (nonatomic, strong) UIView *testView;
@end

@implementation TextViewRichVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self demo1];
    [self demo2];
    [self demo3];
}
//方式1：系统url scheme方法
-(void)demo1{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
             [paragraphStyle setAlignment:NSTextAlignmentLeft];
             [paragraphStyle setLineSpacing:5];
             [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
       
       NSDictionary *contentDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:16.0],NSFontAttributeName,//字体
                                   [UIColor redColor],NSForegroundColorAttributeName,
                                   paragraphStyle,NSParagraphStyleAttributeName, nil//字体颜色
                                   ];
       NSDictionary *highlightDic = [NSDictionary dictionaryWithObjectsAndKeys:
       [UIFont systemFontOfSize:16.0],NSFontAttributeName,//字体
                                     [UIColor blueColor],NSForegroundColorAttributeName, nil//字体颜色
                                   ];
       NSArray *highlightArray = @[highlightDic,highlightDic,highlightDic];
       
       ClickTextView1 *textView = [[ClickTextView1 alloc] initWithFrame:CGRectMake(0, 100, 300, 100) contentStirng:@"请遵守以下协议《支付宝协议》《微信协议》《建行协议》《招行协议》《中国银行协议》《上海银行协议》" contentAttribute:contentDic highlightStringArray:@[@"《支付宝协议》",@"《微信协议》",@"《建行协议》"] hithlightAttribute:highlightArray];
     textView.backgroundColor = [UIColor whiteColor];
       textView.clickStringBlock = ^(NSInteger index, NSString * _Nullable highlightString) {
            NSLog(@"%lu---%@",index,highlightString);
       };
       
       [self.view addSubview:textView];
}
//方式2：自绘背景
-(void)demo2{
    
    ClickTextView2 *clickTextView = [[ClickTextView2 alloc] initWithFrame:CGRectMake(50, 250, 300, 100)];
    [self.view addSubview:clickTextView];
    
    // 方便测试，设置textView的边框已经背景
    clickTextView.backgroundColor = [UIColor cyanColor];
    clickTextView.layer.borderWidth = 1;
    clickTextView.layer.borderColor = [UIColor redColor].CGColor;
    clickTextView.font = [UIFont systemFontOfSize:30];
    //    clickTextView.textColor = [UIColor redColor];
    
    
    NSString *content = @"1234567890承诺书都差不多岁尺布斗粟CBD死UC收不到催上半场低俗";
    // 设置文字
    clickTextView.text = content;
    
    // 设置期中的一段文字有下划线，下划线的颜色为蓝色，点击下划线文字有相关的点击效果
    NSRange range1 = [content rangeOfString:@"承诺书都差"];
    [clickTextView setUnderlineTextWithRange:range1 withUnderlineColor:[UIColor blueColor] withClickCoverColor:[UIColor greenColor] withBlock:^(NSString *clickText) {
        NSLog(@"clickText = %@",clickText);
    }];
    
    // 设置期中的一段文字有下划线，下划线的颜色没有设置，点击下划线文字没有点击效果
    NSRange range2 = [content rangeOfString:@"不到催上半场低俗"];
    [clickTextView setUnderlineTextWithRange:range2 withUnderlineColor:nil withClickCoverColor:[UIColor redColor]  withBlock:^(NSString *clickText) {
        NSLog(@"clickText = %@",clickText);
    }];
}
//方法3：综合方法1和方法2
-(void)demo3{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 400, 300, 100)];
    view.backgroundColor = [UIColor lightPink];
    
//    整段文字属性
       NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
             [paragraphStyle setAlignment:NSTextAlignmentLeft];
             [paragraphStyle setLineSpacing:5];
             [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
       
       NSDictionary *contentDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont systemFontOfSize:16.0],NSFontAttributeName,//字体
                                   [UIColor redColor],NSForegroundColorAttributeName,
                                   paragraphStyle,NSParagraphStyleAttributeName, nil//字体颜色
                                   ];
//    高亮文字属性
       NSDictionary *highlightDic = [NSDictionary dictionaryWithObjectsAndKeys:
       [UIFont systemFontOfSize:16.0],NSFontAttributeName,//字体
                                     [UIColor blueColor],NSForegroundColorAttributeName, nil//字体颜色
                                   ];
       NSArray *highlightArray = @[highlightDic,highlightDic,highlightDic];
//    高亮文字背景
    NSArray *highlightBgColorArray = @[[UIColor redColor],[UIColor yellowColor],[UIColor greenColor]];
       ClickTextView3 *textView = [[ClickTextView3 alloc] initWithFrame:CGRectMake(0, 0, 200, 100) contentStirng:@"请遵守以下协议《支付宝协议》《微信协议》《建行协议》《招行协议》《中国银行协议》《上海银行协议》" contentAttribute:contentDic highlightStringArray:@[@"《支付宝协议》",@"《微信协议》",@"《建行协议》"] hithlightAttribute:highlightArray highlightBgColorArray:highlightBgColorArray];
       textView.backgroundColor = [UIColor whiteColor];
       textView.clickStringBlock = ^(NSInteger index, NSString * _Nullable highlightString) {
            NSLog(@"%lu---%@",index,highlightString);
       };
    [view addSubview:textView];
    
       [self.view addSubview:view];
}
@end
