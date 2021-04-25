//
//  LabelLeaveSpaceVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/15.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "LabelLeaveSpaceVC.h"
#import "MCLabel.h"

@interface LabelLeaveSpaceVC ()

@end

@implementation LabelLeaveSpaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    普通label的text
    
//    富文本行间距的tex
    
//    label的lineSpace
    MCLabel *label3 = [[MCLabel alloc] init];
    [self labelCommonSetting:label3];
    CGRect rect3 = [label3 getSpaceWithLineSpace:10];
    label3.contentInsets = UIEdgeInsetsMake(10, 10, 0, 0);
    label3.frame = CGRectMake((SCREEN_WIDTH - rect3.size.width) * 0.5f, 100, ceilf(rect3.size.width) + 10, ceilf(rect3.size.height) + 10);
    [self.view addSubview:label3];
    NSRange rang3 = NSMakeRange(0, label3.text.length);
    [label3.attributedText enumerateAttribute:NSParagraphStyleAttributeName inRange:rang3 options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        NSMutableParagraphStyle *style = (NSMutableParagraphStyle *)value;
        NSLog(@"lineSpace是：%f",style.lineSpacing);
        
    }];

    NSLog(@"label3:font.pointSize = %f,font.ascender = %f,font.descender = %f,font.capHeight = %f,font.xHeight = %f,font.lineHeight = %f,font.leading = %f",label3.font.pointSize,label3.font.ascender,label3.font.descender,label3.font.capHeight,label3.font.xHeight,label3.font.lineHeight,label3.font.leading);
    
    
//    label的lineHeight
    MCLabel *label4 = [[MCLabel alloc] init];
    [self labelCommonSetting:label4];
    CGRect rect4 = [label4 getSpaceWithLineHeight:30];
    label4.frame = CGRectMake((SCREEN_WIDTH - rect4.size.width) * 0.5f, 300, ceilf(rect4.size.width), ceilf(rect4.size.height));
    [self.view addSubview:label4];
     NSRange rang4 = NSMakeRange(0, label4.text.length);
    [label4.attributedText enumerateAttribute:NSParagraphStyleAttributeName inRange:rang4 options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        
    }];
   
    
    NSLog(@"label4:font.pointSize = %f,font.ascender = %f,font.descender = %f,font.capHeight = %f,font.xHeight = %f,font.lineHeight = %f,font.leading = %f",label4.font.pointSize,label4.font.ascender,label4.font.descender,label4.font.capHeight,label4.font.xHeight,label4.font.lineHeight,label4.font.leading);

//    缩进
    

}
#pragma mark -  通用设置
- (void)labelCommonSetting:(UILabel *)label{
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = LBRandomColor;
    NSString *str = @"在中国枸杞有很多民间叫法，如苟起子、枸杞红实、甜菜子、西枸杞、狗奶子、红青椒、枸蹄子、枸杞果、地骨子、枸茄茄、红耳坠、血枸子、枸地芽子、枸杞豆、血杞子、津枸杞。在宁夏枸杞主产区，宁夏省中宁县，农民们习惯称呼枸杞为“茨”，茨即蒺藜。";
    label.text = str;
    
}

#pragma mark -  缩进直接写
- (UILabel *)getLeaveSpaceLabel {
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor yellowColor];
    NSString *str = @"在中国枸杞有很多民间叫法，如苟起子、枸杞红实、甜菜子、西枸杞、狗奶子、红青椒、枸蹄子、枸杞果、地骨子、枸茄茄、红耳坠、血枸子、枸地芽子、枸杞豆、血杞子、津枸杞。在宁夏枸杞主产区，宁夏省中宁县，农民们习惯称呼枸杞为“茨”，茨即蒺藜。这是由于野生枸杞与蒺藜相似，常被混采作烧柴，在民间把“茨”当作枸杞的俗名叫惯了。在中宁农村，枸杞园称为茨园，拘杞树称为茨树，枸杞枝称为茨条。于是，盛产枸杞的中宁农村又被称为茨乡，富有中宁地方色彩的文化也往往被冠以茨乡的称号，如茨乡戏、茨乡歌谣等。但是，在药材领域里，枸杞即枸杞子，不用茨果，茨实等称谓。";
    NSMutableAttributedString *attributeStr =[[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    // 设置行间距为 要求的行间距减去每行文字的留白部分
    style.lineSpacing = 10 - (label.font.lineHeight - label.font.pointSize);
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName: style};
    [attributeStr addAttributes:dict range:NSMakeRange(0, attributeStr.length)];
  
    // 计算文字的宽高
    CGRect rect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    label.frame = CGRectMake(20, 100, ceilf(rect.size.width), ceilf(rect.size.height));
    label.attributedText = attributeStr;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
   
    return label;
}
#pragma mark -  留白自定义1

#pragma mark -  留白自定义2

#pragma mark -  缩进
-(void)getRetractLabel{
    MCLabel *label = [[MCLabel alloc]init];
    [self.view addSubview:label];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.backgroundColor = [UIColor yellowColor];
    label.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    NSString *str = @"在中国枸杞有很多民间叫法，如苟起子、枸杞红实、甜菜子、西枸杞、狗奶子、红青椒、枸蹄子、枸杞果、地骨子、枸茄茄、红耳坠、血枸子、枸地芽子、枸杞豆、血杞子、津枸杞。在宁夏枸杞主产区，宁夏省中宁县，农民们习惯称呼枸杞为“茨”，茨即蒺藜。这是由于野生枸杞与蒺藜相似，常被混采作烧柴，在民间把“茨”当作枸杞的俗名叫惯了。在中宁农村，枸杞园称为茨园，拘杞树称为茨树，枸杞枝称为茨条。于是，盛产枸杞的中宁农村又被称为茨乡，富有中宁地方色彩的文化也往往被冠以茨乡的称号，如茨乡戏、茨乡歌谣等。但是，在药材领域里，枸杞即枸杞子，不用茨果，茨实等称谓。";
    
    // 注意：在计算文字高度的时候传入的CGSize是文字缩进之后的最大宽度及高度
    CGRect rect = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-40, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    // 注意：计算出来的rect是文字缩进后的自适应宽度和高度 所以在设置文字frame的时候要将设置缩进的边距加回来
    label.frame = CGRectMake(10, 250, ceilf(rect.size.width+20), ceilf(rect.size.height+20));
    
    label.text = str;
   
}

@end
