//
//  ViewController.m
//  LXD_KeyValueObserveDemo
//
//  Created by linxinda on 15/3/15.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "BlockKVOViewController.h"
#import "NSObject+LXD_KVO.h"
#import "LXD_ObservedObject.h"

@interface BlockKVOViewController ()
@property(nonatomic,strong)LXD_ObservedObject *object;
@property (nonatomic, assign) NSInteger testNumber;
@end

@implementation BlockKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RandomBackgroundColor;

    
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 40, 30)];
    [testBtn setTitle:@"测试重复点击" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [testBtn setBackgroundColor:[UIColor orangeColor]];
    [testBtn addTarget:self action:@selector(testClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    
    _object = [LXD_ObservedObject new];
    [_object LXD_addObserver: self forKey: @"observedNum" withBlock: ^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        
        NSLog(@"observedKey = %@",observedKey);
        NSLog(@"oldValue = %@:newValue = %@",oldValue,newValue);
        
    }];
    
    _object.observedNum = @10;
    _testNumber = 10;
}

- (void)testClick {
        NSLog(@"按钮点击");
    _testNumber ++;
    _object.observedNum =  [NSNumber numberWithInteger:_testNumber];
    
}

@end
