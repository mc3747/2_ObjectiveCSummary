//
//  DrawTextViewcontroller.m
//  PQDrawTest
//
//  Created by ios on 16/8/13.
//  Copyright © 2016年 ios. All rights reserved.
//

#import "DrawTextViewcontroller.h"
#import "DrawTexttView.h"
@interface DrawTextViewcontroller ()

@end

@implementation DrawTextViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    DrawTexttView * text = [[DrawTexttView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    text.backgroundColor = [UIColor grayColor];
    [self.view addSubview:text];
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
