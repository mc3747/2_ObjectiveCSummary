//
//  TextViewNonPackageVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/11/21.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "TextViewNonPackageVC.h"
static int const kMaxImageCount  = 3;
static int const kMaxTextLength  = 240;

@interface TextViewNonPackageVC ()<UITextViewDelegate>
@property (weak, nonatomic)  UITextView *feedbackTextView;
@property (nonatomic, weak)  UILabel *placeHolderLb;
@property (weak, nonatomic)  UILabel *countLb;
@property (nonatomic, assign) NSInteger textLocation;//这里声明一个全局属性，用来记录输入位置
@end

@implementation TextViewNonPackageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseView];
}

#pragma mark -  基础视图
- (void)initBaseView {
    UITextView *feedbackTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH - 10, 400)];
    feedbackTextView.delegate = self;
    feedbackTextView.textColor = [UIColor blackColor];
    feedbackTextView.font = [UIFont systemFontOfSize:14];
    feedbackTextView.inputAccessoryView = [[UIView alloc] init];
    if (@available(iOS 11.0, *)) {
        feedbackTextView.smartQuotesType = UITextSmartQuotesTypeNo;
        feedbackTextView.smartDashesType = UITextSmartDashesTypeNo;
        feedbackTextView.smartInsertDeleteType = UITextSmartInsertDeleteTypeNo;
    }
    feedbackTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    feedbackTextView.spellCheckingType = UITextSpellCheckingTypeNo;
    
    [self.view addSubview:feedbackTextView];
    _feedbackTextView = feedbackTextView;
    
    //  在UITextView上面覆盖个UILable,UILable设置为全局变量
    UILabel *placeHolderLb = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH, 20)];
    placeHolderLb.text = @"输入您的宝贵意见";
    placeHolderLb.font = [UIFont systemFontOfSize:14];
    placeHolderLb.enabled = NO;//lable必须设置为不可用
    placeHolderLb.backgroundColor = [UIColor clearColor];
    [_feedbackTextView addSubview:placeHolderLb];
    _placeHolderLb = placeHolderLb;
    
    UILabel *countLb = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70, feedbackTextView.height - 40, 60, 30)];
    countLb.font = [UIFont systemFontOfSize:14];
    countLb.textColor = [UIColor blackColor];
    countLb.textAlignment = NSTextAlignmentRight;
    countLb.text = @"240";
    [self.view addSubview:countLb];
    _countLb = countLb;
}

#pragma mark - text代理
-(void)textViewDidChange:(UITextView *)textView
{
    //  判断len - 不得超过240字
    if(textView.text.length > kMaxTextLength) {
        //  禁用提交按钮
        _placeHolderLb.text = @"";
        //  字数label变红色
        _countLb.textColor = [UIColor redColor];
        
    } else {
        if (textView.text.length == 0) {
            _placeHolderLb.text = @"欢迎您向我们提出宝贵的建议";
            
        } else {
            _placeHolderLb.text = @"";
        }
        
        //  字数label变灰色
        _countLb.textColor = [UIColor grayColor];
    };
    
    //输入含emoji表情
    if (self.textLocation != -1) {
        //截取emoji表情前
        textView.text = [textView.text substringToIndex:self.textLocation];
    };
    
    //显示剩余字数
    _countLb.text = FMT_STR(@"%ld", (long)(kMaxTextLength - textView.text.length));
}

#pragma mark - textView输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //  禁止输入换行
    //    if ([text isEqualToString:@"\n"]) {
    //        return NO;
    //    }
    
    // 过滤本身emoji表情：删除键不可用
    //    if ([textView isFirstResponder]) {
    //        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
    //            return NO;
    //        }
    //    };
    
    //过滤输入法联想表情
    if ([self stringContainsEmoji:text]) {
        //有emoji
        self.textLocation = range.location;
    }else {
        //无emoji
        self.textLocation = -1;
    };
    
    return YES;
}

#pragma mark -  过滤输入法联想表情
- (BOOL)stringContainsEmoji:(NSString *)string
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
                
            };
        };
        returnValue = returnValue?returnValue:[self hasEmoji:string];
        
    }];
    return returnValue;
}

#pragma mark -  正则再次过滤emoji表情
- (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *text = [regex stringByReplacingMatchesInString:string
                                                     options:0
                                                       range:NSMakeRange(0, [string length])
                                                withTemplate:@""];
    BOOL isMatch = [text isEqualToString:@""]?YES:NO;
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    //    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

@end
