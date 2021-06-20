//
//  ViewController.m
//  ArrayAndDictorySummary
//
//  Created by gjfax on 2018/6/1.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "ViewController.h"
#import "ArrayTraverseManager.h"
#import "ArrayExtremeManager.h"
#import "ArraySortManager.h"
#import "DicExtremeManager.h"
#import "DicSortManager.h"
#import "SortSummary.h"
#import "ArrayDeduplicateManger.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *testButton1;
@property (weak, nonatomic) IBOutlet UIButton *testButton2;
@property (weak, nonatomic) IBOutlet UIButton *testButton3;
@property (weak, nonatomic) IBOutlet UIButton *testButton4;
@property (weak, nonatomic) IBOutlet UIButton *testButton5;
@property (weak, nonatomic) IBOutlet UIButton *testButton6;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_testButton1 addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    
    [_testButton2 addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    
    [_testButton3 addTarget:self action:@selector(test3) forControlEvents:UIControlEventTouchUpInside];
    
    [_testButton4 addTarget:self action:@selector(test4) forControlEvents:UIControlEventTouchUpInside];
    
    [_testButton5 addTarget:self action:@selector(test5) forControlEvents:UIControlEventTouchUpInside];
    
    [_testButton6 addTarget:self action:@selector(test6) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -  测试遍历
- (void)test1 {
  
    NSMutableArray *mutalbeArray = [NSMutableArray array];
    for (int i = 0; i < 500; i++) {
        [mutalbeArray addObject:[NSNumber numberWithInt:i]];
    };
    NSArray *array = [NSArray arrayWithArray:mutalbeArray];
    [ArrayTraverseManager traverse_7_WithArray:array];
}

#pragma mark -  测试最值
- (void)test2 {
   
    NSArray *array = [self returnTestArray];
    float max = [[array firstObject] floatValue];
    float min = [[array lastObject] floatValue];
    int maxIndex = 0;
    int minIndex = 0;
    [ArrayExtremeManager extreme_3_WithArray:array max:&max maxIndex:&maxIndex min:&min minIndex:&minIndex];
    NSLog(@"最大值%f，下标%i，最小值%f，下标%i",max,maxIndex,min,minIndex);
}

#pragma mark -  测试排序
- (void)test3 {
    NSArray *array = [self returnTestArray];
    NSArray *newArray = [ArraySortManager sort_1_WithArray:array];
    NSLog(@"%@",newArray);
}

#pragma mark -  测试数组
- (NSArray *)returnTestArray {
    NSMutableArray *mutalbeArray = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        int randomInt = [self getRandomNumber:20 to:80];
        [mutalbeArray addObject:[NSNumber numberWithFloat:randomInt]];
    };
    NSArray *array = [NSArray arrayWithArray:mutalbeArray];
    return array;
}
- (int )getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
};

#pragma mark -  4，字典最值
- (void)test4 {
    NSDictionary *dic = @{@"小A":@"1.89",@"小B":@"1.95",@"小C":@"1.77",@"小D":@"1.72"};
    NSString *maxKey;
    NSString *maxValue;
    [DicExtremeManager extreme_1_WithDic:dic maxKey:&maxKey maxValue:&maxValue];
    NSLog(@"最大的key：%@，最大的value：%@",maxKey,maxValue);
}

#pragma mark -  5，字典排序
- (void)test5 {
    
}
#pragma mark -  6，模型排序
- (void)test6 {
    [SortSummary sortModelDemo];
}

- (IBAction)test7:(id)sender {
     NSArray *originalArr = @[@1, @2, @3, @1, @3,@2];
    NSLog(@"✅方法1：%@",[ArrayDeduplicateManger method1:originalArr]);
    NSLog(@"✅方法2：%@",[ArrayDeduplicateManger method2:originalArr]);
    NSLog(@"✅方法3：%@",[ArrayDeduplicateManger method3:originalArr]);
    NSLog(@"✅方法4：%@",[ArrayDeduplicateManger method4:originalArr]);
}


@end
