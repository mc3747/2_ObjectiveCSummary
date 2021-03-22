//
//  InputWithSpaceVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/12.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "InputWithSpaceVC.h"
#import "UITextField+NumberFormat.h"

@interface InputWithSpaceVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textBankNumber;
@property (nonatomic, strong) UITextField *textIDNumber;
@property (nonatomic, strong) UITextField *textPhoneNumber;
@end

@implementation InputWithSpaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self textBankNumber];
    [self textIDNumber];
    [self textPhoneNumber];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSArray *locationArray = [NSArray array];
    NSInteger limitCount;
    if (textField == _textBankNumber) {
        locationArray = @[@4,@9,@14,@19,@24];
        limitCount = 24;
        
    }else if (textField == _textIDNumber){
        locationArray = @[@6,@15];
        limitCount = 18;
        
    }else {
        locationArray = @[@4,@9];
        limitCount = 11;
    }
    return [UITextField inputTextField:textField
         shouldChangeCharactersInRange:range
                     replacementString:string
                        blankLocations:locationArray
                            limitCount:limitCount];
    
}// @[@6,@15] @[@4,@9,@14,@19,@24] @[@4,@9]

- (UITextField *)textBankNumber {
    if (!_textBankNumber) {
        _textBankNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 250, 40)];
        _textBankNumber.delegate = self;
        _textBankNumber.backgroundColor = [UIColor peachRed];
        _textBankNumber.borderStyle = UITextBorderStyleRoundedRect;
        _textBankNumber.keyboardType = UIKeyboardTypeNumberPad;
        _textBankNumber.placeholder = @"请输入银行卡号";
        [self.view addSubview:_textBankNumber];
    }
    return _textBankNumber;
}
- (UITextField *)textIDNumber {
    if (!_textIDNumber) {
        _textIDNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, 250, 40)];
        _textIDNumber.delegate = self;
        _textIDNumber.backgroundColor = [UIColor greenYellow];
        _textIDNumber.borderStyle = UITextBorderStyleRoundedRect;
        _textIDNumber.keyboardType = UIKeyboardTypeNumberPad;
        _textIDNumber.placeholder = @"请输入身份证号";
        [self.view addSubview:_textIDNumber];
    }
    return _textIDNumber;
}
- (UITextField *)textPhoneNumber {
    if (!_textPhoneNumber) {
        _textPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(50, 210, 250, 40)];
        _textPhoneNumber.delegate = self;
        _textPhoneNumber.backgroundColor = [UIColor blueViolet];
        _textPhoneNumber.borderStyle = UITextBorderStyleRoundedRect;
        _textPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
        _textPhoneNumber.placeholder = @"请输入手机号";
        [self.view addSubview:_textPhoneNumber];
    }
    return _textPhoneNumber;
}

@end
