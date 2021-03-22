//
//  ExampleFooterView.m
//  CCTableDataSourceDemo
//
//  Created by eHome on 17/2/17.
//  Copyright © 2017年 brefChan. All rights reserved.
//

#import "ExampleFooterView.h"

@implementation ExampleFooterItem

@end


@interface ExampleFooterView()

@property (strong, nonatomic)  UIButton *leftButton;
@property (strong, nonatomic)  UILabel *footerTitleLabel;

@end

@implementation ExampleFooterView
@synthesize delegate = _delegate;

+ (CGFloat)footerViewHeightForData:(id)data
{
    return 30;
}

- (void)bindData:(ExampleFooterItem *)data
{
    self.backgroundColor = [UIColor redColor];
    [self.leftButton setTitle:data.buttonString forState:UIControlStateNormal];
    self.footerTitleLabel.text = data.titleString;
}

- (void)leftButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(footerView:leftButtonClick:)])
        [self.delegate footerView:self leftButtonClick:sender];
}

#pragma mark - Getter && Setter
- (id<ExampleFooterViewDelegate>)delegate
{
    return _delegate;
}

- (void)setDelegate:(id<ExampleFooterViewDelegate>)delegate
{
    _delegate = delegate;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}
- (UILabel *)footerTitleLabel {
    if (!_footerTitleLabel) {
        _footerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 200, 30)];
        [self addSubview:_footerTitleLabel];
    }
    return _footerTitleLabel;
}

@end
