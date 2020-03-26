//
//  PriorityLevelVC.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/5/20.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "PriorityLevelVC.h"

@interface PriorityLevelVC ()

@property (nonatomic, strong)  UILabel *labelCenter;
@property (nonatomic, strong)  UILabel *lessThanLabel;
@property (nonatomic, strong)  UILabel *moreThanLabel;

@end

@implementation PriorityLevelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createProityLevelLabel];
    [self createViews];
}


#pragma  mark  - UI

- (void)createProityLevelLabel {
    
    UILabel *leftLabel = [UILabel new];
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.backgroundColor = [UIColor grayColor];
    leftLabel.text  = @"别压我";
    [self.view addSubview:leftLabel];
    //设置左边的约束不被压缩
    [leftLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(5);
    }];
    
    self.labelCenter = [UILabel new];
    self.labelCenter.text  = @"我可以被挤压";
    self.labelCenter.textAlignment = NSTextAlignmentCenter;
    self.labelCenter.userInteractionEnabled = YES;
    self.labelCenter.textColor = [UIColor blackColor];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.labelCenter addGestureRecognizer:ges];
    self.labelCenter.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.labelCenter];
    [self.labelCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLabel);
        make.left.equalTo(leftLabel.mas_right);
    }];
    UILabel *rightLabel = [UILabel new];
    rightLabel.backgroundColor = [UIColor grayColor];
    rightLabel.textColor = [UIColor blackColor];
    rightLabel.text  = @"别压我";
    //设置右边label的约束的优先级
    [rightLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.view addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftLabel);
        make.left.equalTo(self.labelCenter.mas_right);
        make.right.mas_equalTo(-5);
    }];
    
}
/**
 *  上面的约束的优先级是什么意思呢？这里就做一些介绍
 我们先看系统提供的api 然后再来进行分析：
 
 setContentHuggingPriority:forAxis:
 
 Custom views should set default values for both orientations on creation, based on their content, typically to UILayoutPriorityDefaultLow or UILayoutPriorityDefaultHigh. When creating user interfaces, the layout designer can modify these priorities for specific views when the overall layout design requires different tradeoffs than the natural priorities of the views being used in the interface.
 
 
 setContentCompressionResistancePriority:forAxis
 
 Sets the priority with which a view resists being made smaller than its intrinsic size.
 
 Custom views should set default values for both orientations on creation, based on their content, typically to UILayoutPriorityDefaultLow or UILayoutPriorityDefaultHigh. When creating user interfaces, the layout designer can modify these priorities for specific views when the overall layout design requires different tradeoffs than the natural priorities of the views being used in the interface.
 
 
 - (CGSize)intrinsicContentSize
 
 Custom views typically have content that they display of which the layout system is unaware. Overriding this method allows a custom view to communicate to the layout system what size it would like to be based on its content. This intrinsic size must be independent of the content frame, because there’s no way to dynamically communicate a changed width to the layout system based on a changed height, for example.
 
 If a custom view has no intrinsic size for a given dimension, it can return UIViewNoIntrinsicMetric for that dimension.
 
 *
 
 并排三个label，宽度由内容决定。父级View宽度不够时，优先显示左边label和右边label的内容
 遇到这种跟内容压缩、优先级有关的布局，就不得不提Autolayout中的两个重要的属性“Content Compression Resistance”和“Content Hugging”。
 
 Content Compression Resistance = 不许挤我！
 
 对，这个属性说白了就是“不许挤我”
 这个属性的优先级（Priority）越高，越不“容易”被压缩。也就是说，当整体的空间装不下所有的View的时候，Content Compression Resistance优先级越高的，显示的内容越完整。
 Content Hugging = 抱紧！
 
 这个属性的优先级越高，整个View就要越“抱紧”View里面的内容。也就是View的大小不会随着父级View的扩大而扩大。
 
 分析
 
 根据要求，可以将约束分为两个部分：
 
 整体空间足够时，三个label的宽度由内容决定，也就是说，label的“Content Hugging”优先级很高，而且没有固定的Width属性。
 整体空间不够时，左边的label和右边的label更不容易被压缩，也就是“Content Compression Resistance”优先级更高。
 
 重点：
 
 label不设置具体的宽度（width）属性，宽度由内容决定。
 显示的优先级由“Content Compression Resistance”属性的高低决定。
 
 */

- (void)createViews {
    
    self.lessThanLabel = [UILabel new];
    self.lessThanLabel.backgroundColor = [UIColor orangeColor];
    self.lessThanLabel.textColor = [UIColor blackColor];
    self.lessThanLabel.text = [self separatedString];
    [self.view addSubview:_lessThanLabel];
    [self.lessThanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.labelCenter.mas_bottom).offset(10);
        /// 设置与右边的距离最小值为10
        make.right.mas_lessThanOrEqualTo(-10);
    }];
    
    UILabel *labelMoreThan = [UILabel new];
    labelMoreThan.backgroundColor = [UIColor redColor];
    labelMoreThan.text = @"左边的测试label";
    [self.view addSubview:labelMoreThan];
    [labelMoreThan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(self.lessThanLabel.mas_bottom).offset(20);
    }];
    self.moreThanLabel = [UILabel new];
    self.moreThanLabel.backgroundColor = [UIColor orangeColor];
    self.moreThanLabel.textColor = [UIColor blackColor];
    self.moreThanLabel.text = [self separatedString];
    [self.view addSubview:_moreThanLabel];
    [self.moreThanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        /// 设置与左边的距离最小值为10
        make.left.greaterThanOrEqualTo(labelMoreThan.mas_right).offset(10);
        make.top.equalTo(labelMoreThan.mas_top);
        make.right.mas_equalTo(-10);
    }];
    /**
     *   使用greaterThanOrEqualTo  或者lessThanOrEqualTo 的时候一定要注意 如果是左右的话  有一个方向必须是固定的。比如说
     *   本例中的moreThanLabel 他的右边与父视图的约束是固定的。也就是说一个方向固定了。另外一个方向就可以来变动。但是变动是有规律的。
     *   moreThanLabel 的左边和labelMoreThan 的右边有一个约束 有了这个约束才使得 moreThanLabel 的左边 和labelMoreThan 右边距离大于等于10(这个貌似有了约束优先级的味道。。。)
     *
     */
}

#pragma mark - avtions
- (void)tapGesture:(UITapGestureRecognizer*)sender {
    self.labelCenter.text = [self.labelCenter.text stringByAppendingString:@"test"];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.lessThanLabel.text = [self.lessThanLabel.text stringByAppendingString:[self separatedString]];
    self.moreThanLabel.text = [self.moreThanLabel.text stringByAppendingString:@"test"];
    
}

- (NSString *)separatedString{
    
    NSString *str = @"言承旭:累了不要见外\n把我挖起来\n吐个痛快\n看不惯朋友有难\n谁还冷冷的围观\n我的手心\n为你握起来\n朱孝天:烦了不要见外\n把我找出来\n陪你负担\n吴建豪:续杯咖啡的温暖\n一直暖到你想开\n你心情的坑洞让我来填满\n朱孝天:昨天会被今天明天来取代\n动心的感情不会淘汰\n关心常在\n全体:就算你我再热闹喧哗中走散\n友情会在第一时间赶来\n让跳乱的心情平躺下来\n重新的呼吸简单\n深深的\n满满的\n朋友只要你被孤单压的叫不出来\n我第一时间送出关怀\n热热的眼神陪你看开\n找回那片大自然\n为着你抱紧你相信你\n朱孝天:我确定\n周渝民:累了不要见外\n把我挖起来\n吐个痛快\n看不惯朋友有难\n谁还冷冷的围观\n我的手心\n为你握起来\n珠孝天:烦了不要见外\n把我找出来\n陪你负担\n续杯咖啡的温暖\n一直暖到你想开\n你心情的坑洞让我来填满\n吴建豪:昨天会被今天明天来取代\n动心的感情不会淘汰\n关心常在\n全体:就算你我再热闹喧哗中走散\n友情会在第一时间赶来\n让跳乱的心情平躺下来\n重新的呼吸简单\n深深的\n满满的\n朋友只要你被孤单压的叫不出来\n我第一时间送出关怀\n热热的眼神陪你看开\n找回那片大自然\n为着你抱紧你相信你\n吴建豪:我确定";
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    return array[arc4random()%array.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
