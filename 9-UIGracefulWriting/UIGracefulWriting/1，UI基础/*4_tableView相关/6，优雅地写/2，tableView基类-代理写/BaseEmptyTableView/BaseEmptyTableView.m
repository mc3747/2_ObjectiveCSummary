/*********************************************************/
/*                                                       *
 *                                                       *
 *   Follow your heart, but take your brain with you.    *
 *                                                       *
 *                                                       *
 *********************************************************/
//
//  BaseTableView.m
//  BaseTableView
//
//  Created by 刘一峰 on 2017/7/10.
//  Copyright © 2017年 刘一峰. All rights reserved.
//

#import "BaseTableView.h"
#import "UIScrollView+EmptyDataSet.h"

@interface BaseEmptyTableView()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end


@implementation BaseEmptyTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setConfigure];
    }
    return self;
}

- (void)setConfigure {
    //默认属性，如果每个界面需要不同的信息，单独设置，重新赋值
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    self.isAllowScroll = NO;
    self.isAllowRequestDataByTap = YES;
    self.isAllowDisplayPlaceholder = YES;
    self.descriptionString = @"没有消息，点击重试？";
    self.emptyString = @"NO Message！";
    self.emptyImageName = @"placeholder_airbnb";
    self.imageNameWhenLoading = @"loading_imgBlue_78x78";
    self.buttomTitle = @"重新加载";
    self.buttonImageName = @"guanxinwode_nurse";
    self.buttonBgImageName = @"start_btn_bg";
    
    [self addObserver:self forKeyPath:@"isLoading" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    [self hideUselessCutLine];
}
#pragma mark 隐藏多余的分割线
- (void)hideUselessCutLine {
    UIView *footerView = [[UIView alloc]init];
    self.tableFooterView = footerView;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    text = _emptyString;
    font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark 刷新按钮的本文信息
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc]init];
    text = _buttomTitle;
    font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark 单纯的刷新按钮,当使用按钮刷新的时候，最好设置tablview不可滚动(单纯的个人感受，就像UC无网络的情况下，就是使用一个按钮刷新的)
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return  [UIImage imageNamed:_buttonImageName];
}

//含有文本的刷新按钮,会被只含有图片的刷新按钮覆盖

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return  [UIImage imageNamed:_buttonBgImageName];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
    if (_isLoading) {
        return [UIImage imageNamed:_imageNameWhenLoading];
    }
    else {
        return [UIImage imageNamed:_emptyImageName];
    }
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 1;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

#pragma mark 无数据时的描述信息
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = [NSString stringWithFormat:@"%@", _descriptionString] ;
    UIColor *textColor = [UIColor colorWithRed:125/255.0 green:127/255.0 blue:127/255.0 alpha:1.0];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 2.0;
    
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate Methods


//是否显示暂位文本信息
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return _isAllowDisplayPlaceholder;
}
// 显示暂位图时，点击提示信息是否刷新
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return _isAllowRequestDataByTap;
}
// 显示暂位图时，是否允许滑动
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return _isAllowScroll;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return _isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [self requestData];
}


- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    [self requestData];
}


- (void)requestData {
    if (_iDelegate && [_iDelegate respondsToSelector:@selector(requestDataByDelegate)]) {
        [_iDelegate requestDataByDelegate];
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isLoading"]) {
        [self reloadEmptyDataSet];
    }
    //    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}



@end
