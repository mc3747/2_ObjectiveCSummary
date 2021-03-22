//
//  BaseInputView.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/9/17.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "BaseInputView.h"
@interface BaseInputView()
@property (nonatomic, assign) CGSize  originalSize;
@property (nonatomic, assign) BOOL isShowTips;
@end
@implementation BaseInputView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _originalSize = frame.size;
        [self.titleLabel reloadInputViews];
        [self.textField reloadInputViews];
        [self.triangleView reloadInputViews];
        [self.errorTipsLabel reloadInputViews];
    }
    return self;
}
- (void)showTips:(NSString *)tips{
    if (_isShowTips) {
        self.errorTipsLabel.text = tips;
        return;
    };
    GJWeakSelf;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.height += 30;
        weakSelf.triangleView.hidden = NO;
        weakSelf.errorTipsLabel.hidden = NO;
        weakSelf.errorTipsLabel.text = tips;
    }];
    _isShowTips = YES;
    
}
- (void)removeTips{
    if (!_isShowTips) {
        return;
    }
    GJWeakSelf;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.height -= 30;
        weakSelf.triangleView.hidden = YES;
        weakSelf.errorTipsLabel.hidden = YES;
    }];
    _isShowTips = NO;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, 50, _originalSize.height);
        titleLabel.backgroundColor = [UIColor greenYellow];
        titleLabel.textColor = [UIColor blueColor];
        titleLabel.text = @"测试";
        titleLabel.font = [UIFont systemFontOfSize:14.f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UITextField *)textField
{
    if (!_textField) {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(50, 0, _originalSize.width - 70, _originalSize.height);
        [self addSubview:textField];
        _textField = textField;
    }
    return _textField;
}

- (UIView *)triangleView
{
    if (!_triangleView) {
        UIView *triangleView = [[UIView alloc] init];
        triangleView.frame = CGRectMake(0, _originalSize.height - 7, _originalSize.width, 7);
        CAShapeLayer *outlineLayer = [[CAShapeLayer alloc] init];
        outlineLayer.strokeColor = SXRGB16Color(0xE6E6FA).CGColor;
        outlineLayer.lineWidth = 1.0f;
        outlineLayer.fillColor  = SXRGB16Color(0xE6E6FA).CGColor;
        //定义画图的path
        UIBezierPath *path = [[UIBezierPath alloc] init];
        CGPoint point1 = CGPointMake(40, 0);
        CGPoint point2 = CGPointMake(47, 7);
        CGPoint point3 = CGPointMake(33, 7);
        //path移动到开始画图的位置
        [path moveToPoint:point1];
        [path addLineToPoint:point2];
        [path addLineToPoint:point3];
        //关闭path
        [path closePath];
        //三角形内填充颜色
        outlineLayer.path = path.CGPath;
        [triangleView.layer addSublayer:outlineLayer];
        triangleView.hidden = YES;
        [self addSubview:triangleView];
        _triangleView = triangleView;
    }
    
    return _triangleView;
}
- (MCLabel *)errorTipsLabel
{
    if (!_errorTipsLabel) {
        MCLabel *errorTipsLabel = [[MCLabel alloc] init];
        errorTipsLabel.frame = CGRectMake(0, _originalSize.height, _originalSize.width, 30);
        errorTipsLabel.contentInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        errorTipsLabel.font = [UIFont systemFontOfSize:13.f];
        errorTipsLabel.textColor = [UIColor orangeRed];
        errorTipsLabel.backgroundColor = SXRGB16Color(0xE6E6FA);
        errorTipsLabel.hidden = YES;
        [self addSubview:errorTipsLabel];
        _errorTipsLabel = errorTipsLabel;
    }
    return _errorTipsLabel;
}
@end
