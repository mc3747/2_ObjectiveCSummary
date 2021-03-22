//
//  CornerTableViewCell.m
//  CornerViewDemo
//
//  Created by lemon on 2018/8/29.
//  Copyright © 2018年 Lemon. All rights reserved.
//

#import "CornerTableViewCell.h"
#import "UIView+LMExtension.h"
#import "UIImageView+LMExtension.h"

@implementation CornerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return  self;
}

- (void)drawRect:(CGRect)rect{
    
}

- (void)setUpUI{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"Avatar"];
//    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake(10, 5, 20 , 20);
    
    UIImageView *imageView2 = [[UIImageView alloc]init];
//    imageView2.backgroundColor = [UIColor redColor];
    imageView2.image = [UIImage imageNamed:@"Avatar"];
    imageView2.frame = CGRectMake(100, 5, 20 , 20);
    
    UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(170, 5, 20, 20)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(250, 5, 100, 20)];
    label.textColor = [UIColor whiteColor];
    label.text = @"设置圆角设置圆角设置圆角";
    
    /*
    //方式1： cornerRadius + maskToBounds
    //会触发离屏渲染
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    imageView2.layer.cornerRadius = 10;
    imageView2.layer.masksToBounds = YES;
    //不会触发离屏幕渲染
    colorView.layer.cornerRadius = 10;
    colorView.backgroundColor = [UIColor brownColor];
    //设置layer的颜色，不能直接设置label的背景色，这样不会有圆角的效果，如果设置了label的背景色则要加上maskToBounds才有圆角效果
    label.layer.backgroundColor = [UIColor redColor].CGColor;
    label.layer.cornerRadius = 10;
     */
    
    /*
    //方式2：CAShapeLayer + UIBezierPath
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:10].CGPath;
    imageView.layer.mask = mask;
    
    CAShapeLayer *mask2 = [CAShapeLayer new];
    mask2.path = [UIBezierPath bezierPathWithRoundedRect:imageView2.bounds cornerRadius:10].CGPath;
    imageView2.layer.mask = mask2;
    
    colorView.backgroundColor = [UIColor brownColor];
    CAShapeLayer *mask3 = [CAShapeLayer new];
    mask3.path = [UIBezierPath bezierPathWithRoundedRect:colorView.bounds cornerRadius:10].CGPath;
    colorView.layer.mask = mask3;
    
    label.backgroundColor = [UIColor redColor];
    CAShapeLayer *mask4 = [CAShapeLayer new];
    mask4.path = [UIBezierPath bezierPathWithRoundedRect:label.bounds cornerRadius:10].CGPath;
    label.layer.mask = mask4;
     */
    
    //方式3：
    [imageView lm_addCorner:10];
    [imageView2 lm_addCorner:10];
    
    [colorView lm_addCorner:10 borderWidth:1 borderColor:[UIColor clearColor] backGroundColor:[UIColor brownColor]];
    [label lm_addCorner:10 borderWidth:1 borderColor:[UIColor clearColor] backGroundColor:[UIColor redColor]];
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:imageView2];
    [self.contentView addSubview:colorView];
    [self.contentView addSubview:label];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
