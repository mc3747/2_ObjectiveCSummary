//
//  main.m
//  12_Block对变量的捕获
//
//  Created by kk on 2021/5/18.
//

#import <Foundation/Foundation.h>
//🌈auto：自动变量，离开作用域就销毁
void test1(){
    //    写auto，不写auto，一样
    auto int age = 10;
    void (^block)(void) = ^{
        NSLog(@"age--- %d", age);
    };
    age = 20;
    block();
}

//🌈static：局部静态
void test2(){
    static int age = 10;
    void (^block)(void) = ^{
        NSLog(@"age--- %d", age);
    };
    age = 20;
    block();
}

//🌈全局
int age_ = 10;
void test3(){
    void (^block)(void) = ^{
        NSLog(@"age--- %d", age_);
    };
    age_ = 20;
    block();
}

//🌈全局静态
static int age__ = 10;
void test4(){
    void (^block)(void) = ^{
        NSLog(@"age--- %d", age__);
    };
    age__ = 20;
    block();
}

//🌈参数，self和_cmd是作为所有对象方法的隐形参数,是局部变量
//self,调用方法的
//_cmd:表示当前方法的selector
@interface MJPerson : NSObject
@property (copy, nonatomic) NSString *name;
- (void)test;
@end
@implementation MJPerson
- (void)test
{
    void (^block)(void) = ^{
        NSLog(@"-------%d", [self name]);
        NSLog(@"-------%@", [self class]);
        NSLog(@"-------%@", NSStringFromSelector(_cmd));
    };
    block();
}
@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //   局部变量，值捕获
        test1();
        //   局部static变量，指针捕获
        test2();
        //   全局变量，不用捕获，直接访问
        test3();
        test4();
        
        
        MJPerson *person = [[MJPerson alloc] init];
        [person test];
        
    }
    return 0;
}
