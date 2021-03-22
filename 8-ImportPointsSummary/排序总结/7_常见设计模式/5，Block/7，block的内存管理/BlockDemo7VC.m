//
//  BlockDemo7VC.m
//  排序总结
//
//  Created by gjfax on 2020/1/10.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "BlockDemo7VC.h"
#import "Tool.h"
#import <Foundation/Foundation.h>

@interface BlockDemo7VC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *dataSouce;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIButton *confirmButton;
@end

@implementation BlockDemo7VC

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.view addSubview:self.titleButton];
        [self.view addSubview:self.confirmButton];
        [self.view addSubview:self.pickerView];
    
    //    默认选中数据
            [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
        
    //    每行的默认选中数据
        for (int i = 0; i < self.dataSouce.count; ++i) {
            [self.pickerView selectRow:1 inComponent:i animated:YES];
            [self pickerView:self.pickerView didSelectRow:1 inComponent:i];
        }
}
#pragma mark -  点击确认
-(void)confirmAction:(id)sender{
//    根据字符串，得到选择器，选择器得到imp指针，再执行函数
    NSString *index = [self getNumberFromStr:self.titleButton.titleLabel.text];
    NSString *methodName = [NSString stringWithFormat:@"testDemo%@",index];
    SEL selector = NSSelectorFromString(methodName);
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(self, selector);
}

//字符串中获取数字
- (NSString *)getNumberFromStr:(NSString *)str {
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
}

//1，无__block修饰变量
-(void)testDemo1{
    int val = 0;
    void (^blk)(void) = ^{
      printf("in block val = %d\n", val);
    };
    val = 1;
    blk();
}
//2，__block修饰变量
-(void)testDemo2{
    __block int val = 0;
      void (^blk)(void) = ^{
          printf("in block val = %d\n", val);
      };
      val = 1;
      blk();
}
//3，block内改变变量值
-(void)testDemo3{
    __block int val = 0;
    void (^blk)(void) = ^{
       printf("in block val = %d\n", val);
       val = 2;
    };
    val = 1;
    blk();
    printf("after block val = %d\n", val);
}
//4，block读取变量指针
-(void)testDemo4{
//    const char text[] = "hello";
    const char *text = "hello";
    void (^blk)(void) = ^{
              printf("%c \n", text[1]);
        };
          
    blk();
     // Blocks 中，截获自动变量的方法，没有实现对 C 语言数组的截获
}
//5，block读取变量指针
-(void)testDemo5{
    int val = 10;
    const char *fmt = "val = %d\n";
    void (^blk)(void) = ^{printf(fmt, val);};
    
    val = 2;
    fmt = "These values were changed, val = %d\n";
    
    blk();
}
//6,block改变变量的值
/*
 // block 中不可以改变自动变量的值，
 // 可以改变：
 //      1. 静态变量
 //      2. 静态全局变量
 //      3. 全局变量
 */
int global_val = 1;
static int static_global_val = 2;
-(void)testDemo6{
    static int static_val = 3;
      void (^blk)(void) = ^ {
          global_val = 1 * 2;
          static_global_val = 2 * 2;
          static_val = 3 * 2;
      };
    
}
-(void)testDemo7{
    __block int val = 10;
    void (^blk)(void) = ^{val = 1;};
    blk();
    const char *fmt = "val = %d\n";
    printf(fmt, val);
}
-(void)testDemo8{
    id arr = [[[Tool alloc] init] getBlockArray];
    
    typedef void (^blk_t)(void);
    
    blk_t blk = [arr objectAtIndex:0];
    
    blk();
}
-(void)testDemo9{
  
};

#pragma mark -  获取标题
- (void)getTitle:(id)sender {
    
    // 遍历集合中的所有组
    for (int i = 0; i < self.dataSouce.count; ++i) {
        
        // 第i组里面的所有数据
        NSUInteger count = [self.dataSouce[i] count];
        
        // 生成随机数去选中
        u_int32_t ranNum = arc4random_uniform((int)count);
        
        // 获取第i组当前选中的行
        NSInteger selRowNum = [self.pickerView selectedRowInComponent:i];
        
        // 如果随机数与当前选中的行号一致,需要重新生成随机数
        while (selRowNum == ranNum) {
            ranNum = arc4random_uniform((int)count);
        }
        
        // 让pickerView选中数据
        [self.pickerView selectRow:ranNum inComponent:i animated:YES];
        
        // 将数据现实到label上
        [self pickerView:self.pickerView didSelectRow:ranNum inComponent:i];
    }
    
}

#pragma mark - dataSouce
//有几行
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSouce.count;
}
//行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSouce[component] count];
}
//列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return self.dataSouce[component][row];
}

#pragma mark - delegate
// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *selFood = self.dataSouce[component][row];
    NSLog(@"%@", selFood);
    [self.titleButton setTitle:selFood forState:UIControlStateNormal];
}

#pragma mark - lazy loading
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 320)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
//        _pickerView.showsSelectionIndicator = YES;
    }
    return _pickerView;
    
}

- (NSArray *)dataSouce {
    if (!_dataSouce) {
        _dataSouce = @[@[@"1,无__block修饰变量",@"2,__block修饰变量",@"3,block内改变变量值",@"4,4，block改变变量指针",@"5,西红柿",@"6,番茄",@"7,西瓜",@"8,西红柿"]];
      
    }
    return _dataSouce;
}

- (UIButton *)titleButton
{
    if (!_titleButton) {
        _titleButton = [[UIButton alloc] init];
        _titleButton.frame = CGRectMake(0, 100, MAIN_SCREEN_WIDTH, 50);
        [_titleButton setTitle:@"点击选择" forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(getTitle:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton setBackgroundColor:[UIColor greenYellow]];
    }
    
    return _titleButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] init];
        _confirmButton.frame = CGRectMake(0, 150, MAIN_SCREEN_WIDTH, 50);
        [_confirmButton setTitle:@"点击确认" forState:UIControlStateNormal];
        [_confirmButton setBackgroundColor:[UIColor peachRed]];
        [_confirmButton addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmButton;
}
@end
