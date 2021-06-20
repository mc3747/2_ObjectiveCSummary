//
//  AmountInputVC.m
//  排序总结
//
//  Created by gjfax on 2018/9/11.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "AmountInputVC.h"
#import "MMReTextField.h"

#import "NSString+NSStringUtils.h"

@interface AmountInputVC ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet MMReTextField *cardNumber;
@property (strong, nonatomic) IBOutlet MMReTextField *cardholder;
@property (strong, nonatomic) IBOutlet MMReTextField *validUntil;
@property (strong, nonatomic) IBOutlet MMReTextField *cvv;
@property (strong, nonatomic) IBOutlet MMReTextField *date;
@property (strong, nonatomic) IBOutlet MMReTextField *time;


@property (weak, nonatomic) IBOutlet MMReTextField *moneyTextView;
@property (weak, nonatomic) IBOutlet UILabel *kilobitLabel;
@property (weak, nonatomic) IBOutlet UILabel *upperCaseLabel;
@end

@implementation AmountInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cardNumber.pattern = @"^(\\d{4}(?: )){3}\\d{4}$";
    _cardholder.pattern = @"^[a-zA-Z ]{3,}$";
    _validUntil.pattern = @"^(1[0-2]|(?:0)[1-9])(?:/)\\d{2}$";
    _cvv.pattern = @"^\\d{3}$";
    
    _date.pattern = @"^(3[0-1]|[1-2][0-9]|(?:0)[1-9])(?:\\.)(1[0-2]|(?:0)[1-9])(?:\\.)[1-9][0-9]{3}$";
    _time.pattern = @"^(2[0-3]|1[0-9]|(?:0)[0-9])(?::)([0-5][0-9])$";
    
    
    _moneyTextView.pattern = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    self.upperCaseLabel.numberOfLines = 0;
    
    self.moneyTextView.delegate = self;
    //数字只在键盘的上边，有符号显示
    self.moneyTextView.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *textView in self.view.subviews) {
        if ([textView isKindOfClass:[MMReTextField class]]) {
            [textView resignFirstResponder];
        }
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    //把输入金额数字转成大写金额
    if(textField.text && textField.text.length>0){
        self.upperCaseLabel.text = [textField.text formatMoneyUpper];
    }
    
    //千位符
    self.kilobitLabel.text= [textField.text formatMonery];
    
}

//return  收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
