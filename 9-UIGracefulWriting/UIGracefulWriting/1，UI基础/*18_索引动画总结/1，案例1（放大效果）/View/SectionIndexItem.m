
//
//  SectionIndexItem.m
//  TSCustomTableViewIndexs
//
//  Created by lujh on 2017/9/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "SectionIndexItem.h"

@interface SectionIndexItem ()
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIImageView *backgroundImageView;
@end

@implementation SectionIndexItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentView];
        
        _backgroundImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backgroundImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.highlightedTextColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [_titleLabel setHighlighted:highlighted];
    [_backgroundImageView setHighlighted:highlighted];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [self setHighlighted:selected animated:animated];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _contentView.frame = self.bounds;
    _backgroundImageView.frame = self.contentView.bounds;
    _titleLabel.frame = self.contentView.bounds;
}

@end
