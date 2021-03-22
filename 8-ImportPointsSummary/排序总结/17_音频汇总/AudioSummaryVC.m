//
//  AudioSummaryVC.m
//  排序总结
//
//  Created by gjfax on 2018/10/26.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "AudioSummaryVC.h"
#import "AudioSystemVC.h"
#import "AudioPlistVC.h"
#import "AudioPlayVC.h"

@interface AudioSummaryVC ()

@end

@implementation AudioSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)AudioSystemAction:(id)sender {
    AudioSystemVC *VC = [[AudioSystemVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)AudioPlistAction:(id)sender {
    AudioPlistVC *VC = [[AudioPlistVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)AudioPlayAction:(id)sender {
    AudioPlayVC *VC = [[AudioPlayVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
