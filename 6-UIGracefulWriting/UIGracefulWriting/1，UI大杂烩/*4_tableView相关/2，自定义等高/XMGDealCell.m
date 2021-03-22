//
//  XMGDealCell.m
//  06-自定义等高cell01-storyboard
//
//  Created by xiaomage on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGDealCell.h"
#import "XMGDeal.h"

@interface XMGDealCell()
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *priceLabel;
@property (weak, nonatomic) UILabel *buyCountLabel;
@end

@implementation XMGDealCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"deal";
    // 创建cell
    XMGDealCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XMGDealCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

// 1.在initWithStyle:reuseIdentifier:方法中添加子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        UILabel *buyCountLabel = [[UILabel alloc] init];
        buyCountLabel.textAlignment = NSTextAlignmentRight;
        buyCountLabel.font = [UIFont systemFontOfSize:14];
        buyCountLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:buyCountLabel];
        self.buyCountLabel = buyCountLabel;
    }
    return self;
}

// 2.在layoutSubviews方法中设置子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentH = self.contentView.frame.size.height;
    CGFloat contentW = self.contentView.frame.size.width;
    CGFloat margin = 10;
    
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 100;
    CGFloat iconH = contentH - 2 * iconY;
    self.iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // titleLabel
    CGFloat titleX = CGRectGetMaxX(self.iconView.frame) + margin;
    CGFloat titleY = iconY;
    CGFloat titleW = contentW - titleX - margin;
    CGFloat titleH = 21;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
//    CGRectMake(titleX, titleY, titleW, titleH);
    
    // priceLabel
    CGFloat priceX = titleX;
    CGFloat priceH = 21;
    CGFloat priceY = contentH - margin - priceH;
    CGFloat priceW = 70;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    // buyCountLabel
    CGFloat buyCountH = priceH;
    CGFloat buyCountY = priceY;
    CGFloat buyCountX = CGRectGetMaxX(self.priceLabel.frame) + margin;
    CGFloat buyCountW = contentW - buyCountX - margin;
    self.buyCountLabel.frame = CGRectMake(buyCountX, buyCountY, buyCountW, buyCountH);
}

// 3.重写模型的set方法

- (void)setDeal:(XMGDeal *)deal
{
    _deal = deal;
    
    // 设置数据
    self.iconView.image = [UIImage imageNamed:deal.icon];
    self.titleLabel.text = deal.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", deal.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人已购买", deal.buyCount];
}

@end
