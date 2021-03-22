//
//  CQCategoryItemCell.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/6/23.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQCategoryItemCell.h"

@interface CQCategoryItemCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CQCategoryItemCell

#pragma mark - 构造方法

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI搭建

- (void)setupUI {
    // 随机背景色
    self.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.numberOfLines = 0;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
}

#pragma mark - set model

- (void)setModel:(CQCategoryItemModel *)model {
    _model = model;
    
    self.nameLabel.text = _model.name;
}

@end
