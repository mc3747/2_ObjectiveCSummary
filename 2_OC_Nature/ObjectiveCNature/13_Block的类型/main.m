//
//  main.m
//  13_Block的类型
//
//  Created by kk on 2021/5/18.
//

#import <Foundation/Foundation.h>
void (^block)(void);

//放在栈区中，会没销毁
void test1()
{
    // __NSStackBlock__
    int age = 10;
    block = ^{
        NSLog(@"block---------%d", age);
    };
    NSLog(@"%@",[block class]);
    [block release];
}

//调用copy，放在堆区中，会没销毁
void test2()
{
    // __NSMallocBlock__
    int age = 10;
    block = [^{
        NSLog(@"block---------%d", age);
    } copy];
    NSLog(@"%@",[block class]);
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 🌈__NSGlobalBlock__：没有访问auto变量
//        void (^block1)(void) = ^{
//            NSLog(@"block1---------");
//        };
        
        // 🌈__NSStackBlock__：访问了auto变量（备注：选择target，在build setting中选择ARC为False）
//        int age = 10;
//        void (^block2)(void) = ^{
//            NSLog(@"block2---------%d", age);
//        };
//        NSLog(@"%@ %@", [block1 class], [block2 class]);
        
        // 🌈栈区中，栈内存中的block会销毁，
//        test1();
//        block();
        
        // 🌈堆区中，堆内存中的block要自己销毁
        test2();
        block();
        
    }
    return 0;
}
