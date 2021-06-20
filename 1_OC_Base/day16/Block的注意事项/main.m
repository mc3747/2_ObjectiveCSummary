//
//  main.m
//  Block的注意事项
//
//  Created by xiaomage on 15/6/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

    // 1.block中可以访问外面的变量
    /*
    int a = 10;
    void (^myBlock)() = ^{
        NSLog(@"a = %i", a);
    };
    myBlock();
    */
    
    // 2.block中可以定义和外界同名的变量, 并且如果在block中定义了和外界同名的变量, 在block中访问的是block中的变量
    /*
    int a = 10;
    void (^myBlock)() = ^{
        int a  = 20;
        NSLog(@"a = %i", a);
    };
    myBlock();
     */
    
    // 3.默认情况下, 不可以在block中修改外界变量的值
    // 因为block中的变量和外界的变量并不是同一个变量
    // 如果block中访问到了外界的变量, block会将外界的变量拷贝一份到堆内存中
    // 因为block中使用的外界变量是copy的, 所以在调用之前修改外界变量的值, 不会影响到block中copy的值
    /*
    int a = 10;
    NSLog(@"&a = %p", &a);
    void (^myBlock)() = ^{
//        a = 50;
        NSLog(@"&a = %p", &a);
        NSLog(@"a = %i", a);
    };
    a = 20;
    myBlock();
     */
    
    /*
    // 如果想在block中修改外界变量的值, 必须在外界变量前面加上__block
    // 如果在block中修改了外界变量的值, 会影响到外界变量的值
    __block int a = 10;
    NSLog(@"&a = %p", &a);
    void (^myBlock)() = ^{
        a = 50;
        NSLog(@"&a = %p", &a);
        NSLog(@"a = %i", a);
    };
    myBlock();
    NSLog(@"a = %i", a);
     */
    
    /*
    
//     int a = 10; // 如果没有添加__block是值传递
//     void (*myBlock)() = &__main_block_impl_0( __main_block_func_0, &__main_block_desc_0_DATA, a);
//     (myBlock)->FuncPtr)(myBlock);
    
    // 为什么不加__block不能在block中修改外界变量的值
    int a = 10;
    void (^myBlock)() = ^{
//        a = 10;
        NSLog(@"a = %i", a);
    };
    myBlock();
     */
    
    /*
//    a =  10; // 如果加上__block之后就是地址传递, 所以可以在block中修改外界变量的值
//    void (*myBlock)() = &__main_block_impl_0(__main_block_func_0, &__main_block_desc_0_DATA, &a, 570425344);
    
    // 为什么加了__block就可以在block中修改外界变量的值
    __block int a = 10;
    void (^myBlock)() = ^{
        a = 10;
        NSLog(@"a = %i", a);
    };
    myBlock();
     */
    
    
    // block是存储在堆中还是栈中
    // 默认情况下block存储在栈中, 如果对block进行一个copy操作, block会转移到堆中
    // 如果block在栈中, block中访问了外界的对象, 那么不会对对象进行retain操作
    // 但是如果block在堆中, block中访问了外界的对象, 那么会对外界的对象进行一次retain
    
    // 如果在block中访问了外界的对象, 一定要给对象加上__block, 只要加上了__block, 哪怕block在堆中, 也不会对外界的对象进行retain
    // 如果是在ARC开发中就需要在前面加上__weak
    __block Person *p = [[Person alloc] init]; // 1
    
    // 如果在做iOS开发时, 在ARC中不这样写容易导致循环引用
//    Person *p = [[Person alloc] init];
//    __weak Person *weakP = p;
    
    NSLog(@"retainCount = %lu", [p retainCount]);
    void (^myBlock)() = ^{
        NSLog(@"p = %@", p); // 2
//        NSLog(@"p = %p", weakP);
        NSLog(@"block retainCount = %lu", [p retainCount]);
    };
    Block_copy(myBlock);
    myBlock();
    
    [p release]; // 1
    
    
    return 0;
}
