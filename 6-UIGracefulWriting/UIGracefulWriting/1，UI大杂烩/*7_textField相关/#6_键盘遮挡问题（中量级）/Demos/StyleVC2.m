//
//  StyleVC2.m
//  WHC_KeyboardManager(OC)
//
//  Created by WHC on 16/11/26.
//  Copyright © 2016年 WHC. All rights reserved.
//

#import "StyleVC2.h"
#import "WHC_KeyboardManager.h"


@interface StyleVC2 ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation StyleVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"2，ScrollView无键盘头";
    self.view.backgroundColor = LBRandomColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    [self.view addSubview:self.scrollView];
    
    /// 键盘处理配置
    /*******只需要在要处理键盘的界面创建WHC_KeyboardManager对象即可无需任何其他设置*******/
    WHC_KBMConfiguration * configuration = [[WHC_KeyboardManager share] addMonitorViewController:self];
    /// 不要键盘头
    configuration.enableHeader = false;
    
    [_scrollView addSubview: [self returnVerticalStack]];
}

#pragma mark -  返回一个纵向布局的stackView
- (UIStackView *)returnVerticalStack {
    UIStackView *containerView =  [[UIStackView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1000)];
    containerView.backgroundColor = LBRandomColor;
    //子视图布局方向：水平或垂直
    containerView.axis = UILayoutConstraintAxisVertical;//垂直布局
    //子控件依据何种规矩布局
    containerView.distribution = UIStackViewDistributionFillEqually;//子控件均分
    //子控件之间的最小间距
    containerView.spacing = 5;
    //子控件的对齐方式
    containerView.alignment = UIStackViewAlignmentFill;
    
    for (int i = 0; i < 10; i++) {
        if (i < 5) {
            UITextView * text = [UITextView new];
            text.backgroundColor = Wonderful_WhiteColor3;
            text.text = [NSString stringWithFormat:@"UITextView %d",i];
            text.font = [UIFont systemFontOfSize:14];
            text.textColor = [UIColor redColor];
            [containerView addArrangedSubview: text];
        }else {
            UITextField * text = [UITextField new];
            text.backgroundColor = Wonderful_WhiteColor3;
            text.placeholder = [NSString stringWithFormat:@"UITextField %d",i];
            text.textColor = [UIColor blueColor];
            [containerView addArrangedSubview: text];
        }
        
    };
    return containerView;
}


@end
