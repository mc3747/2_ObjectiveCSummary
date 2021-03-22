//
//  ClickableLabelVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/9.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "ClickableLabelVC.h"
#import "TTTAttributeLabelView.h"
#import "ConfigAttributedString.h"
#import "NSString+RichText.h"

@interface ClickableLabelVC ()<TTTAttributeLabelViewDelegate>

@end

@implementation ClickableLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建富文本
    NSString *string = @"Between the husband and earth, each master. All Gou Fei Wu, although a little and Mo to take. YouXianMing but the river breeze, and the mountain of the moon, ear and sound, eyes meet and fineness. Take no ban, be inexhaustible. Is also the creator of the endless Tibet, and I and the children were appropriate.\n夫天地之间，物各有主。苟非吾之所有，虽一毫而莫取。惟江上之清风，与山间之明月，耳得之而为声，目遇之而成色。 取之无禁，用之不竭。是造物者之无尽藏也，而吾与子之所共适。";
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing              = 4.f;
    style.paragraphSpacing         = style.lineSpacing * 4;
    style.alignment                = NSTextAlignmentCenter;
    NSAttributedString *attributedString  = \
    [string createAttributedStringAndConfig:@[[ConfigAttributedString foregroundColor:[UIColor whiteColor] range:string.range],
                                              [ConfigAttributedString paragraphStyle:style range:string.range],
                                              [ConfigAttributedString font:[UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:14.f] range:string.range]]];
    
    // 初始化对象
    TTTAttributeLabelView *attributeLabelView                    = [[TTTAttributeLabelView alloc] initWithFrame:CGRectMake(10, 50, 300, 0)];
    attributeLabelView.attributedString   = attributedString;
    attributeLabelView.delegate           = self;
    attributeLabelView.linkColor          = [UIColor cyanColor];
    
    // 添加超链接
    NSRange range1 = [string rangeOfString:@"YouXianMing"];
    [attributeLabelView addLinkStringRange:range1 flag:@"link1"];
    
    NSRange range2 = [string rangeOfString:@"inexhaustible"];
    [attributeLabelView addLinkStringRange:range2 flag:@"link2"];
    
    NSRange range3 = [string rangeOfString:@"耳得之而为声，目遇之而成色。"];
    [attributeLabelView addLinkStringRange:range3 flag:@"link3"];
    
    // 进行渲染
    [attributeLabelView render];
    [attributeLabelView resetSize];
    [self.view addSubview:attributeLabelView];
}


- (void)TTTAttributeLabelView:(TTTAttributeLabelView *)attributeLabelView linkFlag:(NSString *)flag {
    
    NSLog(@"%@", flag);
}

@end
