//
//  BZBaseTableViewCell.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/10.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "BZBaseTableViewCell.h"

@implementation BZBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
}

@end
