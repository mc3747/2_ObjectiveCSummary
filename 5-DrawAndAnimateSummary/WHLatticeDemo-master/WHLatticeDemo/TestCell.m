//
//  TestCell.m
//  slimController
//
//  Created by zhifanYoung on 16/4/12.
//  Copyright © 2016年 zhifanYoung. All rights reserved.
//

#import "TestCell.h"

@interface TestCell ()

@property (strong, nonatomic)  UILabel *titleLabel;

@property (strong, nonatomic)  UILabel *descLabel;

@end

@implementation TestCell

- (void)configureWithModel:(TestModel *)m {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width * 0.5f, self.bounds.size.height)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.text = m.title;
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.5f, 0, self.bounds.size.width * 0.5f, self.bounds.size.height)];
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.descLabel.adjustsFontSizeToFitWidth = YES;
    self.descLabel.text = m.desc;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
}


@end
