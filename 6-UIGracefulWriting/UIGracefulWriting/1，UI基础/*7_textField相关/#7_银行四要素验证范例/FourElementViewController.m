//
//  FourElementViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/9/17.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "FourElementViewController.h"
#import "BaseInputView.h"
#import "UITextField+NumberFormat.h"
#import "JudgeFormatTool.h"

/*
 1，银行卡
 2，姓名
 3，身份证
 4，预留手机号
 验证码
 */

/*
 1，输入空格展示
 2，失去焦点后，判断格式是否正确：前端验证
 3，错误提示在输入框下，整个坐标向下移
 4，每种textField对应不同的安全键盘
 */
@interface FourElementViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) BaseInputView *inputView1;
@property (nonatomic, strong) BaseInputView *inputView2;
@property (nonatomic, strong) BaseInputView *inputView3;
@property (nonatomic, strong) BaseInputView *inputView4;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL clickState;
@end

@implementation FourElementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BaseInputView *inputView1 = [[BaseInputView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 50)];
    inputView1.titleLabel.text = @"银行卡";
    inputView1.textField.placeholder = @"请输入银行卡号";
    inputView1.textField.delegate = self;
    [self.view addSubview:inputView1];
    _inputView1 = inputView1;
    
    BaseInputView *inputView2 = [[BaseInputView alloc] initWithFrame:CGRectMake(0, inputView1.bottom + 30, SCREEN_WIDTH, 50)];
    inputView2.titleLabel.text = @"姓名";
    inputView2.textField.placeholder = @"请输入姓名";
    inputView2.textField.delegate = self;
    [self.view addSubview:inputView2];
    _inputView2 = inputView2;
    
    BaseInputView *inputView3 = [[BaseInputView alloc] initWithFrame:CGRectMake(0, inputView2.bottom + 30, SCREEN_WIDTH, 50)];
    inputView3.titleLabel.text = @"身份证";
    inputView3.textField.placeholder = @"请输入身份证号";
    inputView3.textField.delegate = self;
    [self.view addSubview:inputView3];
    _inputView3 = inputView3;
    
    BaseInputView *inputView4 = [[BaseInputView alloc] initWithFrame:CGRectMake(0, inputView3.bottom + 30, SCREEN_WIDTH, 50)];
    inputView4.titleLabel.text = @"手机号";
    inputView4.textField.placeholder = @"请输入手机号";
    inputView4.textField.delegate = self;
    [self.view addSubview:inputView4];
    _inputView4 = inputView4;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, inputView4.bottom + 20, SCREEN_WIDTH - 40, 50)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setBackgroundColor:Wonderful_YelloeColor5 forState:UIControlStateNormal];
    [button setBackgroundColor:Wonderful_RedColor5 forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    _button = button;
}

-(void)clickAction{
    if (_clickState) {
         [_inputView1 removeTips];
    }else{
        [_inputView1 showTips:@"错误提示"];
    };
    [self updatePosition];
    _clickState = !_clickState;
}

- (void)updatePosition {
    GJWeakSelf;
    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.inputView2.y = weakSelf.inputView1.bottom + 30;
        weakSelf.inputView3.y = weakSelf.inputView2.bottom + 30;
        weakSelf.inputView4.y = weakSelf.inputView3.bottom + 30;
        weakSelf.button.y = weakSelf.inputView4.bottom + 50;
    }];
}

#pragma mark -  textField的代理方法:限制输入的格式
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSArray *locationArray = [NSArray array];
    NSInteger limitCount;
    if (textField == _inputView1.textField) {
            [_inputView1 removeTips];
            [self updatePosition];
        locationArray = @[@4,@9,@14,@19,@24];
        limitCount = 24;
        
    }else if (textField == _inputView2.textField){
         [_inputView2 removeTips];
        [self updatePosition];
        locationArray = @[@2,@4,@6,@8,@10,@12,@14,@16,@18];
        limitCount = 18;
        
    }else if (textField == _inputView3.textField){
         [_inputView3 removeTips];
        [self updatePosition];
        locationArray = @[@6,@15];
        limitCount = 18;
        
    }else {
         [_inputView4 removeTips];
        [self updatePosition];
        locationArray = @[@3,@8];
        limitCount = 11;
        
    };
    
    return [UITextField inputTextField:textField
         shouldChangeCharactersInRange:range
                     replacementString:string
                        blankLocations:locationArray
                            limitCount:limitCount];
    
};
/*
 重写textfield的setter方法
 失去焦点，判断格式
 开始变化，去掉错误
 内容为空，去掉错误
 */
//// 开始编辑
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if (textField == _inputView1.textField && (textField.text.length <=0)) {
//        [_inputView1 removeTips];
//    }else if (textField == _inputView2.textField && (textField.text.length <=0)) {
//        [_inputView2 removeTips];
//    }else if (textField == _inputView3.textField && (textField.text.length <=0)) {
//        [_inputView3 removeTips];
//    }else{
//         [_inputView4 removeTips];
//    };
//}

// 失去焦点
- (void)textFieldDidEndEditing:(UITextField *)textField{
  
    // 判断是否满足对应的格式
    if (textField == _inputView1.textField) {
        if (textField.text.length >0) {
            if (![JudgeFormatTool isBankCard:textField.text]) {
                [_inputView1 showTips:@"请输入正确的银行卡号"];
                [self updatePosition];
            };
        }else{
            [_inputView1 removeTips];
             [self updatePosition];
        };
       
        
    }else if (textField == _inputView2.textField) {
        if (textField.text.length >0) {
            if (![JudgeFormatTool isBankCard:textField.text]) {
                [_inputView2 showTips:@"请输入正确的姓名"];
                [self updatePosition];
            };
        }else{
            [_inputView2 removeTips];
             [self updatePosition];
        };
        
    }else if (textField == _inputView3.textField) {
        if (textField.text.length >0) {
            if (![JudgeFormatTool isBankCard:textField.text]) {
                [_inputView3 showTips:@"请输入正确的身份证号"];
                [self updatePosition];
                
            };
        }else {
            [_inputView3 removeTips];
             [self updatePosition];
        };
      
    }else if(textField == _inputView4.textField){
        if (textField.text.length >0) {
            if (![JudgeFormatTool isBankCard:textField.text]) {
                [_inputView4 showTips:@"请输入正确的手机号"];
                [self updatePosition];
            };
        }else {
            [_inputView4 removeTips];
             [self updatePosition];
        };
    };
    
}

@end
