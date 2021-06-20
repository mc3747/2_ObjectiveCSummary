//
//  main.m
//  16_Block修改变量的值
//
//  Created by kk on 2021/5/18.
//

#import <Foundation/Foundation.h>
typedef void (^MJBlock)(void);

//1,static
void test1(){
   static int age1 = 10;
    MJBlock block1 = ^{
        age1 = 20;
        NSLog(@"age is %d", age1);
    };
    block1();
};

//2，全局
int age2 = 10;
void test2(){
    MJBlock block1 = ^{
        age2 = 20;
        NSLog(@"age is %d", age2);
    };
    block1();
};

//3，auto,需要block修饰
void test3(){
   __block int age3 = 10;
    MJBlock block1 = ^{
        age3 = 20;
        NSLog(@"age is %d", age3);
    };
    block1();
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test1();
        test2();
        test3();
    }
    return 0;
}
