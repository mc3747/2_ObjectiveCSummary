//
//  CQFilterCell.m
//  iOS_Storage
//
//  Created by 蔡强 on 2018/7/18.
//  Copyright © 2018年 蔡强. All rights reserved.
//

#import "CQFilterCell.h"
#import "CQRegionModel.h"
#import "CQDepartmentModel.h"
#import "CQHouseModel.h"

@interface CQFilterCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CQFilterCell

#pragma mark - 构造方法

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - UI搭建

- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor redColor];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.right.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark - set model

- (void)setModel:(CQFilterBaseModel *)model {
    _model = model;
    
    [self setUserSelected:_model.isSelected];
    
    if ([_model isMemberOfClass:[CQRegionModel class]]) {
        // 大区
        CQRegionModel *regionModel = (CQRegionModel *)_model;
        self.nameLabel.text = regionModel.region_name;
    } else if ([_model isMemberOfClass:[CQDepartmentModel class]]) {
        // 部门
        CQDepartmentModel *departmentModel = (CQDepartmentModel *)_model;
        self.nameLabel.text = departmentModel.department_name;
    } else if ([_model isMemberOfClass:[CQHouseModel class]]) {
        // 门店
        CQHouseModel *houseModel = (CQHouseModel *)_model;
        self.nameLabel.text = houseModel.house_name;
    }
}

#pragma mark - 设置cell选中状态

- (void)setUserSelected:(BOOL)userSelected {
    if (userSelected) {
        self.nameLabel.textColor = [UIColor redColor];
        self.contentView.backgroundColor = [UIColor yellowColor];
    } else {
        self.nameLabel.textColor = [UIColor grayColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
