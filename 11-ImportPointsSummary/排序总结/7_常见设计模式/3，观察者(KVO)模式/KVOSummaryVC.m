//
//  KVOSummaryVC.m
//  排序总结
//
//  Created by gjfax on 2020/2/6.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "KVOSummaryVC.h"

@interface KVOSummaryVC ()

@end

@implementation KVOSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
//1,基本使用
- (IBAction)demo1:(id)sender {
    [self pushVCWithString:@"BaseKVOViewController" and:((UIButton *)sender).titleLabel.text];
}

//2,本质
- (IBAction)demo2:(id)sender {
    [self pushVCWithString:@"KVOEssenceVC" and:((UIButton *)sender).titleLabel.text];
    
}

//3,典型案例
- (IBAction)demo3:(id)sender {
     [self pushVCWithString:@"KVOFreshDemoVC" and:((UIButton *)sender).titleLabel.text];
}

//4，封装
- (IBAction)demo4:(id)sender {
    [self pushVCWithString:@"BlockKVOViewController" and:((UIButton *)sender).titleLabel.text];
}

//5，第三方
- (IBAction)demo5:(id)sender {
}


- (void)pushVCWithString:(NSString *)vcName and:(NSString *)title{
    Class class = NSClassFromString(vcName);
    if (class) {
        UIViewController *vc = [class new];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
