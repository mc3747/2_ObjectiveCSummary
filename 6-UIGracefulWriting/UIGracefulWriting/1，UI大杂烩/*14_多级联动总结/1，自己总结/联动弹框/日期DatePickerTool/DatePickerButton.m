//
//  DatePickerButton.m
//  SmartMedicalPlatformIM
//
//  Created by gjfax on 2019/3/27.
//  Copyright © 2019 SevenShare. All rights reserved.
//


#import "DatePickerButton.h"
#import "DatePickerTool.h"

@interface DatePickerButton()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) DatePickerTool *pickTool;
@end

@implementation DatePickerButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addTarget:self action:@selector(showPicktool) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(showPicktool) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
#pragma mark -  选择工具
- (DatePickerTool *)pickTool
{
    if (!_pickTool) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _pickTool = [[DatePickerTool alloc] init];
        _pickTool.size = CGSizeMake(window.width, 250);
        _pickTool.center = CGPointMake(window.center.x,  SCREEN_HEIGHT + 100);
        
        GJWeakSelf;
        _pickTool.callBlock = ^(NSString *pickDate) {
            NSLog(@"%@",pickDate);
            [weakSelf hidePicktool];
            if (pickDate) {
                if (weakSelf.pickBlock) {
                    weakSelf.pickBlock(pickDate);
                }
            };
            
        };
        ;
        [window addSubview:self.bgView];
        [window addSubview:_pickTool];
        
    }
    
    return _pickTool;
}
#pragma mark -  背景view
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        _bgView.frame = window.bounds;
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.6;
        //给背景添加一个手势，后续方便移除视图
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePicktool)];
        [_bgView addGestureRecognizer:tap];
    }
    
    return _bgView;
}

#pragma mark -  显示
- (void)showPicktool {
    GJWeakSelf;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.pickTool.hidden = NO;
    self.bgView.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        
        weakSelf.pickTool.center = CGPointMake(window.center.x,  SCREEN_HEIGHT -100);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark -  隐藏
- (void)hidePicktool {
    GJWeakSelf;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.pickTool.y += 250;
        weakSelf.pickTool.center = CGPointMake(window.center.x,  SCREEN_HEIGHT + 100);
    } completion:^(BOOL finished) {
        weakSelf.pickTool.hidden = YES;
        weakSelf.bgView.hidden = YES;
    }];
}

- (void)dealloc {
    [_pickTool removeFromSuperview];
    [_bgView removeFromSuperview];
    _pickTool = nil;
    _bgView = nil;
}

@end
