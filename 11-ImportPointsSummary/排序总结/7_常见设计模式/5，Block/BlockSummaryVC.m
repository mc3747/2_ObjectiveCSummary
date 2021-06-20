//
//  BlockSummaryVC.m
//  排序总结
//
//  Created by gjfax on 2020/1/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "BlockSummaryVC.h"
//方案1：里边用strongSelf来代替，嵌套block可以使用两次替换
#define GJWeakSelf  __weak typeof(self) weakSelf = self;
#define GJStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;

//方案2：里边直接使用self
#define weakify(var) __weak typeof(var) XYWeak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = XYWeak_##var; \
_Pragma("clang diagnostic pop")

@interface BlockSummaryVC ()
@property (nonatomic, strong) NSArray *testArray1;
@property (nonatomic, strong) NSMutableArray *testArray2;
@end

@implementation BlockSummaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testArray1 = @[@"1",@"2",@"3"];
    [self testDemo1];
    [self testDemo2];
}

//使用GJWeakSelf
- (void)testDemo1{
    printf("retain count:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(self)));
    GJWeakSelf
    [self.testArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GJStrongSelf
        [strongSelf.testArray2 addObject:[NSString stringWithFormat:@"%@✅",(NSString *)obj]];
    }];
    printf("retain count:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(self)));
}

//使用weakify
- (void)testDemo2{
    printf("retain count:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(self)));
    weakify(self)
    [self.testArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        strongify(self)
        [self.testArray2 addObject:[NSString stringWithFormat:@"%@✅",(NSString *)obj]];
    }];
    printf("retain count:%ld\n", CFGetRetainCount((__bridge CFTypeRef)(self)));
}

#pragma mark -  所有按钮响应同一个方法
- (IBAction)buttonAction:(id)sender {
    
    NSString *title = ((UIButton *)sender).titleLabel.text;
    NSString *index = [self getNumberFromStr:title];
    NSString *vcName = [NSString stringWithFormat:@"BlockDemo%@VC",index];
    Class class = NSClassFromString(vcName);
    if (class) {
             UIViewController *ctrl = class.new;
             ctrl.title = title;
             ctrl.view.backgroundColor = [UIColor lavender];
             [self.navigationController pushViewController:ctrl animated:YES];
         };
}
//字符串中获取数字
- (NSString *)getNumberFromStr:(NSString *)str {
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];

    return[[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];

}


@end
