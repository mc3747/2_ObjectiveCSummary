//
//  SGCountdownVC.m
//  SGEasyButtonExample
//
//  Created by kingsic on 2017/9/25.
//  Copyright © 2017年 kingsic. All rights reserved.
//

#import "SGCountdownVC.h"
#import "UIButton+SGCountdown.h"
#import "UIButton+SGImagePosition.h"
#import "JKCountDownDateButton.h"

@interface SGCountdownVC ()

@end

@implementation SGCountdownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JKCountDownDateButton *countDownBtn = [[JKCountDownDateButton alloc] initWithFrame:CGRectMake(50, 300, 300, 50)];
    [countDownBtn setBackgroundColor:LBRandomColor];
    countDownBtn.titleLabel.textColor = [UIColor orangeColor];
    countDownBtn.titleLabel.text  = @"00 : 00 : 00 : 00";
    [countDownBtn countDownWithDate:[NSDate dateWithTimeIntervalSinceNow:10]];
//    变化
    [countDownBtn countDownChanging:^NSString *(JKCountDownDateButton *countDownLable, NSDate *endTime, NSTimeInterval seconds, NSDictionary *DHMSInfo, NSString *defaultText) {
        //自己格式化
        NSInteger D = [[DHMSInfo objectForKey:@"D"] integerValue];
        NSInteger H = [[DHMSInfo objectForKey:@"H"] integerValue];
        NSInteger M = [[DHMSInfo objectForKey:@"M"] integerValue];
        NSInteger S = [[DHMSInfo objectForKey:@"S"] integerValue];
        
        return [NSString stringWithFormat:@"%0.2zd : %0.2zd : %0.2zd : %0.2zd",D, H,M,S];
    }];
    
//    结束
    [countDownBtn countDownFinished:^NSString *(JKCountDownDateButton *countDownLable, NSDate *endTime, NSTimeInterval seconds, NSString *defaultText) {
        [countDownLable setBackgroundColor:LBRandomColor];
        return @"00 : 00 : 00 : 00";
    }];
    
//    点击
    [countDownBtn countDownClick:^(JKCountDownDateButton *countDownButton) {
        NSLog(@"点击了按钮");
    }];
    
    [self.view addSubview:countDownBtn];
}

- (IBAction)countdownBtn_action:(UIButton *)sender {
    [sender SG_countdownWithSec:30];
}

- (IBAction)countdownBtn2_action:(UIButton *)sender {
    [sender SG_countdownWithSecond:31];
}

- (IBAction)countdownBtnWithCompletion:(UIButton *)sender {
    [sender SG_countdownWithSecond:30 completion:^{
        [sender setTitle:@"重新获取" forState:(UIControlStateNormal)];
    }];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
