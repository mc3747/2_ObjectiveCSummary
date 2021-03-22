//
//  XMGStatusCell.m
//  07-自定义非等高cell-xib
//
//  Created by xiaomage on 15/6/2.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGStatusCell.h"
#import "XMGStatus.h"

@interface XMGStatusCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@end

@implementation XMGStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    XMGStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置label每一行文字的最大宽度
    // 为了保证计算出来的数值 跟 真正显示出来的效果 一致
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
}

- (void)setStatus:(XMGStatus *)status
{
    _status = status;
    
    if (status.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    self.nameLabel.text = status.name;
    self.iconView.image = [UIImage imageNamed:status.icon];
    if (status.picture) {
        self.pictureView.hidden = NO;
        self.pictureView.image = [UIImage imageNamed:status.picture];
    } else {
        self.pictureView.hidden = YES;
    }
    self.contentLabel.text = status.text;
    
    // 强制布局
    [self layoutIfNeeded];
    
    // 计算cell的高度
    if (self.pictureView.hidden) { // 没有配图
        status.cellHeight = CGRectGetMaxY(self.contentLabel.frame) + 10;
    } else { // 有配图
        status.cellHeight = CGRectGetMaxY(self.pictureView.frame) + 10;
    }
}

@end
