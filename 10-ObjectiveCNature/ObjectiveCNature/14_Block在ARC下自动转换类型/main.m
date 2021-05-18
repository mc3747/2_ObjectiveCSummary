//
//  main.m
//  14_Block在ARC下自动转换类型
//
//  Created by kk on 2021/5/18.
//

#import <Foundation/Foundation.h>

/*
 在ARC环境下，编译器会根据情况自动将栈上的block复制到堆上,以下四种情况：
 */



//1——block作为函数返回值时,捕获局部变量
typedef void (^MJBlock)(void);
MJBlock myblock()
{
    int age = 10;
    return ^{
        NSLog(@"---------%d",age);
    };
}
void test1(){
    NSLog(@"%@", [myblock() class]);
}

//2-将block赋值给__strong指针时
void test2(){
    int age = 10;
    // 强指针引用
    MJBlock block = ^{
        NSLog(@"---------%d", age);
    };
    
    NSLog(@"%@", [block class]);
}

//3-block作为Cocoa API中方法名含有usingBlock的方法参数时
void test3(){
    NSArray *array = @[@3,@7,@2];
    NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSNumber *tNumber1 = (NSNumber *)obj1;
        NSNumber *tNumber2 = (NSNumber *)obj2;
        //因为不满足sortedArrayUsingComparator方法的默认排序顺序，则需要交换
        if ([tNumber1 integerValue] < [tNumber2 integerValue])
            return NSOrderedDescending;
        return NSOrderedAscending;
        //因为满足sortedArrayUsingComparator方法的默认排序顺序，则不需要交换
        if ([tNumber1 integerValue] > [tNumber2 integerValue])
            return NSOrderedAscending;
        return NSOrderedDescending;
        
    }];
    NSLog(@"%@",newArray);
}

//4-block作为GCD API的方法参数时
void test4(){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        <#code to be executed once#>
    });
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        test1();
        test2();
        test3();
    }
    return 0;
}
