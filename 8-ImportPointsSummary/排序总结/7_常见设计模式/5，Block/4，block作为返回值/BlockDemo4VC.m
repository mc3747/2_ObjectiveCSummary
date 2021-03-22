//
//  BlockDemo4VC.m
//  排序总结
//
//  Created by gjfax on 2020/1/10.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "BlockDemo4VC.h"
// =====================================================
/*
 TestClass1
 */
// =====================================================
@interface TestClass1 : NSObject
typedef NSString *(^NmuberBlock)(NSString *inputValue);

/*直接声明block */
- (NSString *(^)(NSString *))nameBlock;

/*typedef声明block */
@property(nonatomic, copy)NmuberBlock numberBlock;

//方法直接方法声明1
- (void)inputNameBlock:(NSString *(^)(NSString *inputStr))nameBlock;

//方法typedef方法声明2
- (void)inputNumberBlock:(NmuberBlock )numberBlock;
@end

@implementation TestClass1

/*直接实现 */
- (NSString *(^)(NSString *))nameBlock{
    return ^NSString *(NSString *inputValue){ //返回值为Block块
        return [inputValue stringByAppendingString:@"直接实现block"];//Block块内部的返回值，这个才是整个方法真正的返回值
    };
}

/*typedef实现block */
- (NmuberBlock)numberBlock{
    return ^NSString *(NSString *inputValue) {
        return [inputValue  stringByAppendingString:@"使用typedef实现block"];
    };
}


//直接方法实现
- (void)inputNameBlock:(NSString *(^)(NSString *inputStr))nameBlock {
    NSString *inputStr;
    inputStr = nameBlock(inputStr);//将inputStr交给外部处理，然后再返回这里
    NSLog(@"%@", inputStr);//将处理过的inputStr输出
}

//typedef方法实现
- (void)inputNumberBlock:(NmuberBlock )numberBlock {
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSDate *datenow = [NSDate date];
//    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSString *inputStr;
    NSLog(@"拼接前字符串：%@", inputStr);
    NSLog(@"拼接前线程：%@",[NSThread currentThread]);
    NSLog(@"拼接前时间：%@",[NSDate date]);
    inputStr = numberBlock(inputStr);//将inputStr交给外部处理，然后再返回这里
    NSLog(@"拼接后字符串：%@", inputStr);//将处理过的inputStr输出
    NSLog(@"拼接后线程：%@",[NSThread currentThread]);
    NSLog(@"拼接后时间%@",[NSDate date]);
    
}

@end



// =====================================================
/*
 主控制器
 */
// =====================================================
@interface BlockDemo4VC ()

@end

@implementation BlockDemo4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    #pragma mark - 1，无返回值：内部block
            void (^sumBlock)(int ,int ) = ^(int a,int b){
                NSLog(@"%d + %d = %d",a,b,a+b);
            };
            sumBlock(10,10);
            
    #pragma mark - 2，无返回值：内部block
            NSString* (^logBlock)(NSString *,NSString *) = ^(NSString * str1,NSString *str2){
                return [NSString stringWithFormat:@"%@%@",str1,str2];
            };
            NSLog(@"%@", logBlock(@"我是",@"Block"));
            

            TestClass1 *testClass = [[TestClass1 alloc] init];
    #pragma mark - 3，有返回值：外部直接调用
            NSLog(@"%@", testClass.nameBlock(@"123"));
            
    #pragma mark - 4，有返回值：外部typedef调用
            NSLog(@"%@", testClass.numberBlock(@"123"));
            
    #pragma mark - 5，有返回值：外部使用方法调用
            [testClass inputNameBlock:^NSString *(NSString *inputStr) {
                //对inputStr进行处理
                inputStr = @"123";//给inputStr赋值
                inputStr = [inputStr stringByAppendingString:@"456"];//给inputStr添加字段
                return inputStr;//将处理好的inputStr返回
            }];
            
    #pragma mark - 6，有返回值：外部使用方法typedef调用
            [testClass inputNumberBlock:^NSString *(NSString *inputStr) {
                 NSLog(@"拼接中线程：%@",[NSThread currentThread]);
                //对inputStr进行处理
                inputStr = @"789";//给inputStr赋值
                inputStr = [inputStr stringByAppendingString:@"JQK"];//给inputStr添加字段
                [NSThread sleepForTimeInterval:2.f];
                return inputStr;//将处理好的inputStr返回
            }];
    
}



@end
