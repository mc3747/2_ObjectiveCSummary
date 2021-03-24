//
//  ExampleHeaderView.m
//  CCTableDataSourceDemo
//
//  Created by eHome on 17/2/17.
//  Copyright © 2017年 brefChan. All rights reserved.
//

#import "ExampleHeaderView.h"

@implementation ExampleHeaderItem

@end



@interface ExampleHeaderView()
@property (strong, nonatomic)  UILabel *exampleTitleLabel;
@property (strong, nonatomic)  UIButton *rightExampleButton;

@end

@implementation ExampleHeaderView

@synthesize delegate = _delegate;

+ (CGFloat)headerViewHeightForData:(id)data
{
    return 40;
}

- (void)bindData:(ExampleHeaderItem *)data
{
    self.backgroundColor = [UIColor greenColor];
    self.exampleTitleLabel.text = data.headerTitle;
    [self.rightExampleButton setTitle:data.buttonTitle forState:UIControlStateNormal];
}

- (void)exampleButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:rightButtonClick:)])
        [self.delegate headerView:self rightButtonClick:sender];
}

- (id<ExampleHeaderViewDelegate>)delegate
{
    return _delegate;
}

- (void)setDelegate:(id<ExampleHeaderViewDelegate>)delegate
{
    _delegate = delegate;
}

- (UIButton *)rightExampleButton {
    if (!_rightExampleButton) {
        _rightExampleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        [_rightExampleButton addTarget:self action:@selector(exampleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightExampleButton];
    }
    return _rightExampleButton;
}

- (UILabel *)exampleTitleLabel {
    if (!_exampleTitleLabel) {
        _exampleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 200, 40)];
        [self addSubview:_exampleTitleLabel];
    }
    return _exampleTitleLabel;
}
@end
