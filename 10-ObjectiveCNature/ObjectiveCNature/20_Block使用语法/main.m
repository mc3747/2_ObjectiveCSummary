//
//  main.m
//  20_Block使用语法
//
//  Created by kk on 2021/5/19.
//

#import <Foundation/Foundation.h>
// =====================================================
/*
 block的定义
 */
// =====================================================
//🌈：直接定义block
void test1(void){
//1，先声明，再赋值
    int (^sum1)(int,int);
    sum1 = ^(int a,int b){
        return a + b;
    };
    
//2，声明的同时赋值
    int (^sum2)(int,int) = ^(int a,int b){
        return a + b;
    };
    
    NSLog(@"%d",sum1(7,8));
    NSLog(@"%d",sum2(9,9));
}

//🌈：使用typedef定义block
typedef int(^Sum)(int,int);
void test2(void){
    Sum sum = ^(int a,int b){
        return a + b;
    };
    NSLog(@"%d",sum(7,8));
}

// =====================================================
/*
 block作为函数参数和返回值
 */
// =====================================================
@interface Person : NSObject
- (void)useBlockPara1:(int(^)(int,int))sum;
- (void)useBlockPara2:(Sum )sum;
@end
@implementation Person
//🌈block作为参数1：
- (void)useBlockPara1:(int(^)(int,int))sum {
    NSLog(@"结果:%d",sum(3,5));
}
//🌈block作为参数2
- (void)useBlockPara2:(Sum )sum{
    NSLog(@"结果:%d",sum(4,5));
}

- (int(^)(int,int))useBlockReturn1{
    int (^sum)(int, int) = ^(int a,int b){
        return a + b;
    };
    return sum;
}
- (Sum)useBlockReturn2{
   Sum sum = ^(int a,int b){
       return a + b;
   };
    return  sum;
}
@end

// =====================================================
/*
入口调用
 */
// =====================================================
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//🌈block的定义
//        test1();
//        test2();
        
//🌈block作为参数
        Person *person = [Person new];
//        int(^sum1)(int ,int ) = ^(int a,int b){
//            return a + b;
//        };
//        [person useBlockPara1:sum1];
//
//        Sum sum2 = ^(int a,int b){
//            return a + b;
//        };
//        [person useBlockPara2:sum2];
        
//🌈block作为返回结果
        NSLog(@"%d",[person useBlockReturn1](4,5)) ;
        NSLog(@"%d",[person useBlockReturn2](8,5));
    }
    return 0;
}
