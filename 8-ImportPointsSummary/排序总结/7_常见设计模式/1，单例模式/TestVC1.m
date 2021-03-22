//
//  TestVC1.m
//  单例
//
//  Created by gjfax on 2017/2/16.
//  Copyright © 2017年 macheng. All rights reserved.
//

#import "TestVC1.h"
#import "SingltonTest.h"

@interface TestVC1 ()

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"testVC1单例地址%@",[SingltonTest shareInstance]);
    NSLog(@"testVC1元素内容%li",(long)[SingltonTest shareInstance].age);
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
