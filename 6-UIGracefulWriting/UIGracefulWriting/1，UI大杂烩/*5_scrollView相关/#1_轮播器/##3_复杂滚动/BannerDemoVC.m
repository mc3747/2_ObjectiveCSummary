//
//  BannerDemoVC.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/15.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "BannerDemoVC.h"
#import "CustomBannerView.h"
#import "UIControl+Category.h"
#import "UIImage+Category.h"

@interface BannerDemoVC ()
@property (nonatomic, weak) __block CustomBannerView *bannerView;
@end

@implementation BannerDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Wonderful_YelloeColor3;
    [self addBanner];
    [self addCycleView];
    [self addAutoView];
    [self addImageSize];
    [self addImageSpace];
    [self addBottomPage];
    [self addRollStyle];
}
#pragma mark -  添加banner
- (void)addBanner {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 7; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    };
    CustomBannerView *bannerView = [[CustomBannerView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 150) datas:datas];
    [self.view addSubview:bannerView];
    _bannerView = bannerView;
}
#pragma mark -  是否循环
- (void)addCycleView {
    CGRect frame = CGRectMake(0, 270, 300, 50);
    __weak typeof (self)weakSelf = self;
    UIView *view = [self addLabelAndSwitchWithFrame:frame title:@"循环滚动" block:^(BOOL isOn) {
        
        weakSelf.bannerView.pagerView.isInfiniteLoop = isOn;
        [weakSelf.bannerView.pagerView updateData];
    }];
     [self.view addSubview:view];
}
#pragma mark -  是否自动滚动
- (void)addAutoView {
    CGRect frame = CGRectMake(0, 340, 300, 50);
    __weak typeof (self)weakSelf = self;
    UIView *view = [self addLabelAndSwitchWithFrame:frame title:@"自动滚动" block:^(BOOL isOn) {
       weakSelf.bannerView.pagerView.autoScrollInterval = isOn ? 3.0:0;
    }];
    [self.view addSubview:view];
}

#pragma mark -  图片大小
- (void)addImageSize {
    CGRect frame = CGRectMake(0, 410, 300, 50);
    __weak typeof (self)weakSelf = self;
    UIView *view = [self addLabelAndSliderWithFrame:frame title:@"图片大小" block:^(float value) {
        float width = CGRectGetWidth(weakSelf.bannerView.pagerView.frame);
        float heighth = CGRectGetHeight(weakSelf.bannerView.pagerView.frame);
        weakSelf.bannerView.pagerView.layout.itemSize = CGSizeMake(width * value, heighth *value);
        [weakSelf.bannerView.pagerView setNeedUpdateLayout];
    }];
    [self.view addSubview:view];
}

#pragma mark -  图片间距
- (void)addImageSpace {
    CGRect frame = CGRectMake(0, 480, 300, 50);
    __weak typeof (self)weakSelf = self;
    UIView *view = [self addLabelAndSliderWithFrame:frame title:@"图片间距" block:^(float value) {
        weakSelf.bannerView.pagerView.layout.itemSpacing = 30 * value;
        [weakSelf.bannerView.pagerView setNeedUpdateLayout];
    }];
    [self.view addSubview:view];
}

#pragma mark -  底部分页间距
- (void)addBottomPage {
    CGRect frame = CGRectMake(0, 550, 300, 50);
    __weak typeof (self)weakSelf = self;
    UIView *view = [self addLabelAndSliderWithFrame:frame title:@"底部页码" block:^(float value) {
        weakSelf.bannerView.pageControl.pageIndicatorSize = CGSizeMake(6*(1+value), 6*(1+value));
        weakSelf.bannerView.pageControl.currentPageIndicatorSize = CGSizeMake(8*(1+value), 8*(1+value));
        weakSelf.bannerView.pageControl.pageIndicatorSpaing = (1+value)*10;
    }];
    [self.view addSubview:view];
}


#pragma mark -  滚动方式
- (void)addRollStyle {
 
    CGRect frame = CGRectMake(0, 620, 300, 50);
    UIView * view= [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    
    UIStackView * verticalView = [[UIStackView alloc] initWithFrame:frame];
    verticalView.backgroundColor = [UIColor yellowColor];
    verticalView.axis = UILayoutConstraintAxisHorizontal;
    verticalView.distribution = UIStackViewDistributionFillEqually;
    verticalView.spacing = 10;
    verticalView.alignment = UIStackViewAlignmentFill;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"滚动方式:";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [verticalView addArrangedSubview:titleLabel];

    NSArray *titleArray = @[@"普通",@"线性",@"翻转"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateHighlighted];
          __weak typeof (self)weakSelf = self;
        [button bk_addEventHandler:^(id  _Nonnull sender) {
            weakSelf.bannerView.pagerView.layout.layoutType = i;
            [weakSelf.bannerView.pagerView setNeedUpdateLayout];
        } forControlEvents:UIControlEventTouchUpInside];
        [verticalView addArrangedSubview:button];
    };
    
    [self.view addSubview:verticalView];
}

#pragma mark -  label + switch
- (UIView *)addLabelAndSwitchWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                 block:(void (^)(BOOL isOn)) returnBlock {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor yellowColor];
  //label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.5f, frame.size.height)];
    label.text = title;
    [view addSubview:label];
  //switch（标准控件，宽50，高30）
    UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake(frame.size.width * 0.5f, 10,  frame.size.width * 0.5f, frame.size.height)];
    [switch1 setOn:NO];
    [switch1 bk_addEventHandler:^(id  _Nonnull sender) {
        returnBlock(((UISwitch *)sender).isOn);
    } forControlEvents:UIControlEventValueChanged];
    [view addSubview:switch1];
    return view;
}

#pragma mark -  label + slider
- (UIView *)addLabelAndSliderWithFrame:(CGRect)frame
                                 title:(NSString *)title
                                 block:(void (^)(float value)) returnBlock {
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor yellowColor];
    //label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.5f, frame.size.height)];
    label.text = title;
    [view addSubview:label];
    
    //slider
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(frame.size.width * 0.5f, 10,  frame.size.width * 0.5f, frame.size.height)];
    slider1.minimumValue = 0;//设置最小值
    slider1.maximumValue = 1;//设置最大值
    slider1.value = 0.f;//设置默认值
    [slider1 bk_addEventHandler:^(id  _Nonnull sender) {
        returnBlock(((UISlider *)sender).value);
    } forControlEvents:UIControlEventValueChanged];
    [view addSubview:slider1];
    return view;
}
@end
