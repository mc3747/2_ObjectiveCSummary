//
//  ConfirmViewController.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/4/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ConfirmVC.h"

@interface ConfirmVC ()


@end

@implementation ConfirmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *contentScrollview = [UIScrollView new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    contentScrollview.backgroundColor = [UIColor redColor];
    [self.view addSubview:contentScrollview];
    [contentScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        
    }];
    UIView *contentView = [UIView new];
    [contentScrollview addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
        make.width.equalTo(contentScrollview);
        
    }];
    UILabel *lastLabel;
    for (NSInteger i = 0; i < 20; i ++) {
        UILabel *contentLabel = [UILabel new];
        contentLabel.numberOfLines = 0;
        contentLabel.backgroundColor = [self randomColor];
        contentLabel.text = [self randomText];
        [contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            if (lastLabel) {
                make.top.equalTo(lastLabel.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(20);
            }
        }];
        lastLabel = contentLabel;
    }
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastLabel.mas_bottom);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  random  color  text and datasource-
- (UIColor *)randomColor {
    UIColor *color = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0  blue:arc4random()%255/256.0  alpha:1.0f];
    return color;
}
- (NSString *)randomText {
    CGFloat length = arc4random() % 50 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:[NSString stringWithFormat:@"%@",[self separatedString]]];
    }
    return str;
}

//分割字符串
- (NSString *)separatedString{
    
    NSString *str = @"言承旭:累了不要见外\n把我挖起来\n吐个痛快\n看不惯朋友有难\n谁还冷冷的围观\n我的手心\n为你握起来\n朱孝天:烦了不要见外\n把我找出来\n陪你负担\n吴建豪:续杯咖啡的温暖\n一直暖到你想开\n你心情的坑洞让我来填满\n朱孝天:昨天会被今天明天来取代\n动心的感情不会淘汰\n关心常在\n全体:就算你我再热闹喧哗中走散\n友情会在第一时间赶来\n让跳乱的心情平躺下来\n重新的呼吸简单\n深深的\n满满的\n朋友只要你被孤单压的叫不出来\n我第一时间送出关怀\n热热的眼神陪你看开\n找回那片大自然\n为着你抱紧你相信你\n朱孝天:我确定\n周渝民:累了不要见外\n把我挖起来\n吐个痛快\n看不惯朋友有难\n谁还冷冷的围观\n我的手心\n为你握起来\n珠孝天:烦了不要见外\n把我找出来\n陪你负担\n续杯咖啡的温暖\n一直暖到你想开\n你心情的坑洞让我来填满\n吴建豪:昨天会被今天明天来取代\n动心的感情不会淘汰\n关心常在\n全体:就算你我再热闹喧哗中走散\n友情会在第一时间赶来\n让跳乱的心情平躺下来\n重新的呼吸简单\n深深的\n满满的\n朋友只要你被孤单压的叫不出来\n我第一时间送出关怀\n热热的眼神陪你看开\n找回那片大自然\n为着你抱紧你相信你\n吴建豪:我确定";
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    return array[arc4random()%array.count];
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
