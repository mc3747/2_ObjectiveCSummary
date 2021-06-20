//
//  SimpleDelegateTestVC.m
//  排序总结
//
//  Created by gjfax on 2018/9/10.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "SimpleDelegateTestVC.h"
#import "SimpleDelegateTestView.h"
@interface SimpleDelegateTestVC ()

@end

@implementation SimpleDelegateTestVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandColor;
    //初始化下testView
    SimpleDelegateTestView *testview = [[SimpleDelegateTestView alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//实现testView中未实现的方法
-(void)getTheCurrentViewName:(NSString *)string{
    
    NSLog(@"这就是我想要的效果:%@",string);
    
}



@end
