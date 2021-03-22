//
//  BlockDemo1VC.m
//  排序总结
//
//  Created by gjfax on 2020/1/10.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "BlockDemo1VC.h"
typedef int (^Sum2)(int,int);

@class Button;
typedef void (^ButtonBlock) (Button *);
@interface Button : NSObject
@property (nonatomic, copy) ButtonBlock block;
- (void)click;
@end

@implementation Button
- (void)click {
    NSLog(@"我被第一次点击了");
    _block(self);
    NSLog(@"我被第二次点击了");
 
}
@end


@interface BlockDemo1VC ()

@end

@implementation BlockDemo1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    test1();
       Button *btn = [[Button alloc] init];
       btn.block = ^(Button *btn) {
           NSLog(@"按钮%@被点击了",btn);
       };
       [btn click];
}

// 定义方法一：直接在内部定义
void test1() {
    // block的定义
    int (^Sum1)(int,int) = ^(int a,int b) {
        return a + b;
    };
    
    // block的调用
    NSLog(@"%i",Sum1 (3,4));
}

// 定义方法二：使用typedef在外部定义
void test2() {
    // 声明一个block类型变量
    Sum2 sum;
    // 实现这个变量类型
    sum = ^(int a,int b) {
        return a + b;
    };
    // 调用这个变量
    NSLog(@"%i",sum(3,5));
}

// 注意事项：使用typedef在外部定义
void test3() {
    Sum2 sum;
    // block外部变量没有修饰
    int c = 15;
    // block外部有__block修饰
    __block d = 16;
    // 实现这个变量类型
    sum = ^(int a,int b) {
        NSLog(@"%i",c);
        d = 18;
        return a + b;
    };
    // 调用这个变量
    NSLog(@"%i",sum(3,5));
}

@end
