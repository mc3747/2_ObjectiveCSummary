//
//  MJAppView.m
//  测试架构
//
//  Created by MJ Lee on 2018/7/13.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MJAppView.h"
#import "MJApp.h"

@interface MJAppView()
@property (weak, nonatomic) UIImageView *iconView;
@property (weak, nonatomic) UILabel *nameLabel;
@end

@implementation MJAppView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.frame = CGRectMake(0, 0, 100, 100);
        [self addSubview:iconView];
        _iconView = iconView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(0, 100, 100, 30);
        nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nameLabel];
        _nameLabel = nameLabel;
    }
    return self;
}

- (void)setApp:(MJApp *)app
{
    _app = app;
    
    self.iconView.image = [UIImage imageNamed:app.image];
    self.nameLabel.text = app.name;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(appViewDidClick:)]) {
        [self.delegate appViewDidClick:self];
    }
}

@end
