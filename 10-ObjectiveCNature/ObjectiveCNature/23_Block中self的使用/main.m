//
//  main.m
//  23_Block中self的使用
//
//  Created by kk on 2021/5/20.
//

#import <Foundation/Foundation.h>

@interface Person:NSObject
@property(copy,nonatomic) void(^blockTest)(NSString *str);
-(void)test1;
-(void)doSomething:(NSString *)str;
@end
@implementation Person
-(void)test1{
    //会产生循环引用
    self.blockTest = ^(NSString *str) {
        [self doSomething1:str];
    };
    self.blockTest(@"gg");
    
    //不会产生循环引用
//    void(^blockTest)(NSString *str) = ^(NSString *str) {
//        [self doSomething1:str];
//    };
//    self.blockTest = blockTest;
//    self.blockTest(@"kk");
    
};
-(void)test2{
    __weak typeof(self) weakSelf = self;
    self.blockTest = ^(NSString *str) {
        [weakSelf doSomething1:str];
        [weakSelf doSomething2:str];
    };
    self.blockTest(@"gaga");
};
-(void)test3{
// 如果不相互持有，类似于以下，用self就没问题
//    [UIView animateWithDuration:0.45 animations:^{
//            self.schoolName = @"ZJJ";
//        }];
}
-(void)doSomething1:(NSString *)str{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"输出文字：%@",str);
    });
    
};
-(void)doSomething2:(NSString *)str{
    NSLog(@"输出文字：%@",str);
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *person = [Person new];
        NSLog(@"person引用计数为%ld",CFGetRetainCount((__bridge CFTypeRef)(person)));
        [person test2];
        NSLog(@"person引用计数为%ld",CFGetRetainCount((__bridge CFTypeRef)(person)));
    }
    return 0;
}
