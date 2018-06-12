//
//  ViewController.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/7.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Practical.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testBtn1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *testString = @"用户姓";
    NSLog(@"%@",[testString hidePhoneTFContent]);
    NSLog(@"%@",[testString hideUserNameStr]);
    
}





@end
