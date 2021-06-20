//
//  InputFloatVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/4/9.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "InputFloatVC.h"
#import "WSTextField.h"

@interface InputFloatVC ()

@end

@implementation InputFloatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WSTextField *username = [[WSTextField alloc]initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH-60, 30)];
    username.ly_placeholder = @"Username";
    //改输入框placeholder的颜色
    username.placeholderSelectStateColor = [UIColor redColor];
    username.placeholderNormalStateColor = [UIColor cyanColor];
    username.textField.textColor = [UIColor blackColor];
    [self.view addSubview:username];
    
    WSTextField *password = [[WSTextField alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(username.frame)+30, SCREEN_WIDTH-60, 30)];
    password.textField.secureTextEntry = YES;
    password.ly_placeholder = @"Password";
    password.textField.textColor = [UIColor blackColor];
    [self.view addSubview:password];
    
}



@end
