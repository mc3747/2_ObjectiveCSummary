//
//  SKBaseTableViewCell.m
//  Masonry
//
//  Created by shavekevin on 16/4/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKBaseTableViewCell.h"

@implementation SKBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}
/**
 *  下面这两行是布局用 如果不写   约束没加载。视图为空 因为约束的添加是在updateconstraints 里的
 */

- (void)layOutViews {
    
//    //这个加上是为了解决约束冲突
//    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
//    self.contentView.frame = self.frame;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

/**
 *  高度计算
 *
 *  @return cell 高
 */
- (CGFloat)calculateHeight{
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    return [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
