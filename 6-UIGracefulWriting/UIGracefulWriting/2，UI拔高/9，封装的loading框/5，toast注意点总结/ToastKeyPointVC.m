//
//  ToastKeyPointVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2020/1/14.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "ToastKeyPointVC.h"
// =====================================================
/*
 1，普通键盘
 2，搜狗键盘等第三方
 3，有键盘展示的时候，先收键盘，再弹toast
 4，有键盘展示的时候，toast覆盖在键盘上
 5，无键盘展示的时候，弹toast
 */
// =====================================================
@interface ToastKeyPointVC ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *toast;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ToastKeyPointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textField];
    [self toast];
    [self confirmButton];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)confirmAction{
    [self showToast:@"错误"];
    
//    if (self.timer) {
//        [self invalidateShowedTimer];
//    }
//    self.timer = [NSTimer timerWithTimeInterval:((float)0.5)/1000
//                                            target:self selector:@selector(hideToast)
//                                          userInfo:nil repeats:NO];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)showToast:(NSString *)string{
    self.toast.text = string;
    [self.window addSubview:self.toast];
}
-(void)hideToast{
    [self.toast removeFromSuperview];
}
- (void)invalidateShowedTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
#pragma mark 键盘出现
- (void)keyboardWillShow:(NSNotification *)note{
     _window = [[[UIApplication sharedApplication] windows] lastObject];
}

#pragma mark 键盘消失
- (void)keyboardWillHide:(NSNotification *)note
{
    _window = [[[UIApplication sharedApplication] windows] firstObject];
}

#pragma mark -  懒加载
- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 50)];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.placeholder = @"点击输入";
        _textField.backgroundColor = Wonderful_RedColor6;
        [self.view addSubview:_textField];
    }
    
    return _textField;
}

- (UILabel *)toast
{
    if (!_toast) {
        _toast = [[UILabel alloc] init];
        _toast.size = CGSizeMake(SCREEN_WIDTH - 40, 30);
        _toast.center = self.view.center;
        _toast.backgroundColor = [UIColor clearColor];
        _toast.textColor = [UIColor whiteColor];
        _toast.font =  [UIFont systemFontOfSize:14];
        _toast.numberOfLines = 0;
        _toast.shadowColor = [UIColor darkGrayColor];
        _toast.shadowOffset = CGSizeMake(1, 1);
    }
    
    return _toast;
}
- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 50)];
        [_confirmButton setTitle:@"显示toast" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_confirmButton];
    }
    
    return _confirmButton;
}

@end
