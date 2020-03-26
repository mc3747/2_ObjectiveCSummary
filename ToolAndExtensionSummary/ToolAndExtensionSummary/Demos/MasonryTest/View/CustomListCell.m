//
//  CustomListTableViewCell.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/4/25.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "CustomListCell.h"
#import "SKCustomListModel.h"
#import "MMPlaceHolder.h"

@interface CustomListCell ()

@property (nonatomic, strong) UIView * tagView;

@property (nonatomic, strong) UIView * dataView;

@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UILabel * contentLabel;



@property (nonatomic, assign) BOOL has;

@end
@implementation CustomListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        //这个加上是为了解决约束冲突
//        self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
//        self.contentView.frame = self.frame;
        self.has = NO;
    }
    return self;
}
-(void)setModel:(SKCustomListModel *)model{
    
    _model = model;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.picImageView.backgroundColor = [UIColor orangeColor];
    self.dataView.backgroundColor = [UIColor blackColor];
    self.tagView.backgroundColor = [UIColor blueColor];
    self.collectionControl.backgroundColor = [UIColor greenColor];
}

-(void)layoutSubviews {
    
    if (self.model.type == 2) {
        self.titleLabel.preferredMaxLayoutWidth = self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 20 - 20 - 10 - 105;
    }
    else if (self.model.type == 1 && self.model.hasPic) {
        self.titleLabel.preferredMaxLayoutWidth = self.contentLabel.preferredMaxLayoutWidth= CGRectGetWidth([UIScreen mainScreen].bounds) - 20 - 20 - 10 - 90;

    } else {
        
    self.titleLabel.preferredMaxLayoutWidth = self.contentLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 20 - 20;
    }
    [super layoutSubviews];
    
}
- (void)updateConstraints {
    
    [super updateConstraints];
    if (!_has) {
        [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.height.equalTo(@50);
        }];
        
        [self.dataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.tagView.mas_bottom).offset(10);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
        }];
        
        [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.tagView.mas_bottom).offset(50);
            make.width.equalTo(@90);
            make.height.equalTo(@90);
        }];
        
        [self.picImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.picImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagView.mas_bottom).offset(10 + 30 + 10);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.picImageView.mas_left).offset(-10);
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.right.equalTo(self.titleLabel);
        }];
        
        [self.collectionControl mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.top.greaterThanOrEqualTo(self.picImageView.mas_bottom) priorityHigh];
            [make.top.greaterThanOrEqualTo(self.contentLabel.mas_bottom) priorityMedium];
            [make.top.greaterThanOrEqualTo(self.titleLabel.mas_bottom) priorityLow];
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5).priority(MASLayoutPriorityDefaultLow);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
        }];
        _has = YES;
    }
    // 有tag  或者  日期
    if (self.model.hasTag) {
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
        }];
        
        [self.dataView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagView.mas_bottom).offset(10);
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagView.mas_bottom).offset(10);
        }];
    }else{
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        
        [self.dataView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
        }];
        
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagView.mas_bottom).offset(10 + 30 + 10);
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagView.mas_bottom).offset(10 + 30 + 10);
        }];
    }
    
    // 图片
    if (self.model.type == 2) {
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@105);
            make.height.equalTo(@70);
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.picImageView.mas_left).offset(-10);
        }];
        
        
    }else if (self.model.type == 1 && self.model.hasPic) {
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@90);
            make.height.equalTo(@90);
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.picImageView.mas_left).offset(-10);
        }];
        
    }else{
        [self.picImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
            make.height.equalTo(@0);
        }];
        
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.picImageView.mas_left).offset(0);
        }];
        
        
    }
    
    // title content
    if (self.model.title.length == 0 || [self.model.title isEqualToString:@""]) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom);
        }];
    }else{
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        }];
    }
    
    if (self.model.content.length == 0 || [self.model.content isEqualToString:@""]) {
        [self.collectionControl mas_updateConstraints:^(MASConstraintMaker *make) {
            [make.top.greaterThanOrEqualTo(self.contentLabel.mas_bottom).offset(-10) priorityMedium];
        }];
    }
    
//    [self.collectionControl mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
//    }];

}
#pragma mark |---- lazy laod

- (UIView *)tagView{
    if (!_tagView) {
        _tagView = [[UIView alloc] init];
        _tagView.backgroundColor = [UIColor redColor];
        [_tagView showPlaceHolder];
        [self.contentView addSubview:_tagView];
    }
    return _tagView;
}

- (UIView *)dataView{
    if (!_dataView) {
        _dataView = [[UIView alloc] init];
        _dataView.backgroundColor = [UIColor brownColor];
        [_dataView showPlaceHolder];
        [self.contentView addSubview:_dataView];

    }
    return _dataView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.numberOfLines = 2;
        [_titleLabel showPlaceHolder];
        [self.contentView addSubview:_titleLabel];

    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor yellowColor];
        _contentLabel.numberOfLines = 2;
        [_contentLabel showPlaceHolder];
        [self.contentView addSubview:_contentLabel];

    }
    return _contentLabel;
}


- (UIImageView *)picImageView{
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.backgroundColor = [UIColor purpleColor];
        [_picImageView showPlaceHolder];
        [self.contentView addSubview:_picImageView];

    }
    return _picImageView;
}

- (UIControl *)collectionControl{
    if (!_collectionControl) {
        _collectionControl = [[UIControl alloc] init];
        _collectionControl.backgroundColor = [UIColor blackColor];
        [_collectionControl showPlaceHolder];
        [self.contentView addSubview:_collectionControl];

    }
    return _collectionControl;
}
@end
