//
//  ViewController.m
//  正则表达式
//
//  Created by gjfax on 2017/1/10.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "MatchingMethodVC.h"

@interface MatchingMethodVC () <UITextFieldDelegate>
@property (nonatomic, copy) NSString *textFieldStr;
@property (nonatomic, copy) NSString *filterStr;
@property (nonatomic, strong) UITextField *textField;
@end

/* 正则表达式提供了一种在指定文本文档中按指定模式进行搜索，并能基于匹配模式进行修改文本的一种方式。*/
@implementation MatchingMethodVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    RandomBackgroundColor;
    
    UILabel *desLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 200, 30)];
    desLab.text = @"正则表达式练习";
    desLab.textColor = [UIColor blackColor];
    [self.view addSubview:desLab];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 110, 200, 30)];
    textField.delegate = self;
    _textField = textField;
    textField.placeholder = @"正则表达式验证";
    [self.view addSubview:textField];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 80, 50)];
    [confirmBtn setTitle:@"谓词匹配" forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:RandColor];
    [confirmBtn addTarget:self action:@selector(confirm1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    UIButton *confirmBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 150, 80, 50)];
    [confirmBtn2 setTitle:@"rang筛选" forState:UIControlStateNormal];
    [confirmBtn2 setBackgroundColor:RandColor];
    [confirmBtn2 addTarget:self action:@selector(confirm2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn2];
    
    UIButton *confirmBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(220, 150, 80, 50)];
    [confirmBtn3 setTitle:@"正则筛选" forState:UIControlStateNormal];
    [confirmBtn3 setBackgroundColor:RandColor];
    [confirmBtn3 addTarget:self action:@selector(confirm3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn3];
}
#pragma mark -  谓词筛选
- (void)confirm1 {
    [_textField resignFirstResponder];

    if ([self validateNumber:_textFieldStr]) {
         _filterStr = @"全是数字，很👌";
    }else {
        _filterStr = @"不全是数字哟";
    };
    [self showAlert];
}
#pragma mark -  range筛选
- (void)confirm2 {
    [_textField resignFirstResponder];
    
    if ( [self rangeOfString:_textFieldStr options:NSRegularExpressionSearch]) {
         _filterStr =   [self rangeOfString:_textFieldStr options:NSRegularExpressionSearch];
    } else {
        _filterStr = @"亲，输入为空喔！";
    };
    
    [self showAlert];
}

#pragma mark -  正则筛选
- (void)confirm3 {
    [_textField resignFirstResponder];
    
    [self regularExpression:_textFieldStr];
    
    [self showAlert];
}

#pragma mark -  弹框
- (void)showAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"过滤数字" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:_filterStr style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:defaultAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UITextField代理
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    _textFieldStr = textField.text;
    
    return YES;
}

    //只包含0-9的数字
#pragma mark - 方式一：正则表达式与NSPredicate连用（正则判断）
    /* 谓词：在计算机语言的环境下，谓词是指条件表达式的求值返回真或假的过程。*/
- (BOOL)validateNumber:(NSString *) textString
{
    NSString* number=@"^[0-9]*$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:textString];
}

#pragma mark - 方式二：NSString方法（正则筛选：适用于匹配一次）
- (NSString *)rangeOfString:(NSString *)aString options:(NSStringCompareOptions)mask {
    aString = @"// Do any additional setup after loading the view, typically from a nib.";
    NSRange range = [aString rangeOfString:@"(?:[^,])*\\." options:NSRegularExpressionSearch];;
    if (range.location != NSNotFound) {
        NSLog(@"range ：%@", [aString substringWithRange:range]);
        return [aString substringWithRange:range];
        }
    return nil;
}

#pragma mark - 方式三：正则表达式类（NSRegularExpression）（正则筛选：适用于匹配多次）
- (void)regularExpression:(NSString *)searchText{
     searchText = @"// Do any additional setup after loading the view, nib., typically from a nib.";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?:[^,])*\\." options:NSRegularExpressionCaseInsensitive error:&error];
    
//    匹配一次
//    NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
    
//    匹配多次
    NSMutableString *resultString = [NSMutableString stringWithFormat:@"结果是："];
    NSArray *matches = [regex matchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, [searchText length])];
    for (NSTextCheckingResult *result in matches) {
        NSRange matchRange = result.range;
        NSString *matchString = [searchText substringWithRange:matchRange];
        [resultString appendString:matchString];
    }
    
//    [regex enumerateMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, [searchText length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//
//    }];
    
    if (resultString) {
        _filterStr = resultString;
    }else {
        _filterStr = @"没有满足条件哦😯";
    }
}
@end
