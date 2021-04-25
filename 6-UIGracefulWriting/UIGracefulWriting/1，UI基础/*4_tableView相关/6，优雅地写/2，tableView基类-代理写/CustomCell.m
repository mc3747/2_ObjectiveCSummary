//
//  CustomCell.m
//  BaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 40, 30)];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 40, 30)];
        _name.text = @"lyf";
        _name.textColor = [UIColor blackColor];

    }
    return _name;
}

- (void)setText:(NSString *)text {
    _text = text;
    _label.text = text;
}

- (void)setupUI {
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.name];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
