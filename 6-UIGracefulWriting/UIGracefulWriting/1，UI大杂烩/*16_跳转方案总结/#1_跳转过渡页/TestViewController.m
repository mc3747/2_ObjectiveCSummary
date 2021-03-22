//
//  TestViewController.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/25.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "TestViewController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "Transition.h"
#import "AAPLMenuViewController.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模拟webview的切换实现";
    [self addBigButton];
    [self addSmallButton];
    [self addDetailModalBtn];
}
                  
#pragma mark -  三种方式
- (void)addBigButton {
    UIStackView *containerView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
    containerView.axis = UILayoutConstraintAxisHorizontal;
    containerView.distribution = UIStackViewDistributionFillEqually;
    containerView.spacing = 10;
    containerView.alignment = UIStackViewAlignmentFill;
    NSArray *array = @[@"覆盖view",@"重写push",@"重写present"];
    for (NSInteger i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 100 + i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGesture:)];
        [label addGestureRecognizer:gesture];
        label.userInteractionEnabled = YES;
        [containerView addArrangedSubview:label];
    }
    
    [self.view addSubview:containerView];
}
#pragma mark -  三种跳转方式
- (void)addGesture:(UITapGestureRecognizer *)sender {
    
    if (sender.view.tag == 100) {
        Test1ViewController *vc = [[Test1ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(sender.view.tag == 101){
        Test2ViewController *vc = [[Test2ViewController alloc] init];
        
        CATransition* transition = [CATransition animation];
        
        transition.duration =0.4f;
        
        transition.type = kCATransitionMoveIn;
        
        transition.subtype = kCATransitionFromTop;
        
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        
        [self.navigationController pushViewController:vc animated:NO];
        
    }else {
        Test3ViewController *vc = [[Test3ViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = [Transition sharedTransition];
        
        [self presentViewController:vc animated:YES completion:nil];
    }
}
#pragma mark -  系统默认方式modal
- (void)addSmallButton {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, SCREEN_WIDTH, 30)];
    label.text = @"系统modal效果示例";
    [self.view addSubview:label];
    
    UIStackView *containerView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 350, SCREEN_WIDTH, 100)];
    containerView.axis = UILayoutConstraintAxisHorizontal;
    containerView.distribution = UIStackViewDistributionFillEqually;
    containerView.spacing = 10;
    containerView.alignment = UIStackViewAlignmentFill;
    NSArray *array = @[@"CoverVertical",@"FlipHorizontal",@"CrossDissolve",@"PartialCurl"];
    for (NSInteger i = 0; i < array.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
        label.text = array[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.tag = 200 + i;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGesture1:)];
        [label addGestureRecognizer:gesture];
        label.userInteractionEnabled = YES;
        [containerView addArrangedSubview:label];
    }
    
    [self.view addSubview:containerView];
}
                  
#pragma mark -  四种跳转方式
- (void)addGesture1:(UITapGestureRecognizer *)sender {
    Test3ViewController *vc = [[Test3ViewController alloc] init];
    switch (sender.view.tag) {
        case 200:
             vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            break;
        case 201:
             vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            break;
        case 202:
             vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            break;
        case 203:
             vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
            break;
        default:
            break;
    };
      [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark -  添加详细modalBtn
- (void)addDetailModalBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 470, SCREEN_WIDTH, 80)];
    [btn setTitle:@"modal的详细跳转示例" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor lightPink] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(jumpToDetailModal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
     
- (void)jumpToDetailModal {
    // 1.获取当前的StoryBoard面板
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"AAPLMenuViewController" bundle:nil];
    
    // 2.通过标识符找到对应的页面
    AAPLMenuViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"AAPLMenuViewController"];
    
   
    [self.navigationController pushViewController:vc animated:YES];
}
@end
