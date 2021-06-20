//
//  MacroCommonUseVC.m
//  排序总结
//
//  Created by gjfax on 2020/3/27.
//  Copyright © 2020 macheng. All rights reserved.
//
#import "MacroCommonUseVC.h"

//1,搭配使用:
    //•   在 Block 内如果需要访问 self 的方法、变量，建议使用 weakSelf。
    //•   如果在 Block 内需要多次 访问 self，则需要使用 strongSelf。
#define WeakSelf __weak typeof(self) weakSelf = self;
#define StrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

//2,任何对象:
    // @WeakObj(self);  @StrongObj(self);
    //  使用直接用self
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;


@interface MacroCommonUseVC ()
@property (nonatomic, assign) int age;
@end

@implementation MacroCommonUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self;
   dispatch_async(dispatch_get_main_queue(), ^{
       [self printTest];
       [self printTest];
       self.age = 16;
       [self printCount:self];
              });
}
-(void)printTest{
    NSLog(@"测试打印");
}
-(void)printCount:(id)object{
    NSLog(@"✅self引用计数为%ld",CFGetRetainCount((__bridge CFTypeRef)(object)));
}
-(void)dealloc{
     NSLog(@"控制器销毁");
}
@end
