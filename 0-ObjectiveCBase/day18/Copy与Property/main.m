//
//  main.m
//  Copy与Property
//
//  Created by xiaomage on 15/6/29.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"

int main(int argc, const char * argv[]) {

    
    // 1.copy的第一个用途, 防止外界修改内部的数据
    /*
    NSMutableString *temp = [NSMutableString stringWithFormat:@"lnj"];
    
    Person *p = [[Person alloc] init];
    p.name = temp;
    
    // 问题: 修改了外面的变量, 影响到了对象中的属性
    [temp appendString:@" cool"];
    
    NSLog(@"name = %@", p.name);
    
    // 记住: 以后字符串属性都用copy
     */
    
    /*
    __block int num = 10;
    void (^myBlock)() = ^{
        num = 20;
        NSLog(@"%i", num);
    };
    myBlock();
     */
    /*
    // block默认存储在栈中, 栈中的block访问到了外界的对象, 不会对对应进行retain
    // block如果在堆中, 如果在block中访问了外界的对象, 会对外界的对象进行一次retain
    Person *p = [[Person alloc] init];
    NSLog(@"retainCount = %lu", [p retainCount]);
    void (^myBlock)() = ^{
        NSLog(@"%@", p);
        NSLog(@"retainCount = %lu", [p retainCount]);
    };
    Block_copy(myBlock); // 将block转移到堆中
    myBlock();
     */
    
    // 2.可以使用copy保存block, 这样可以保住block中使用的外界对象的命
    /*
    // 避免以后调用block的时候, 外界的对象已经释放了
    Dog *d = [[Dog alloc] init]; // 1
    NSLog(@"retainCount = %lu", [d retainCount]);
    Person *p = [[Person alloc] init];
    p.pBlock = ^{
     // 2//如果在block中访问了外界的对象, 会对外界的对象进行一次retain
       NSLog(@"%@", d);
    };
    NSLog(@"retainCount = %lu", [d retainCount]); // 2

    // 如果狗在调用block之前释放了, 那么程序就会崩溃
    [d release]; // 1
    
    p.pBlock();
    
    [p release];
     */
    
    // 3.注意点: copy block之后引发循环引用
    // 如果对象中的block又用到了对象自己, 那么为了避免内存泄露, 应该将对象修饰为__block
    __block Person *p = [[Person alloc] init]; // 1
    p.name = @"lnj";
    NSLog(@"retainCount = %lu", [p retainCount]);
    p.pBlock = ^{
        NSLog(@"name = %@", p.name); // 2
    };
    NSLog(@"retainCount = %lu", [p retainCount]);
    p.pBlock();
    
    [p release]; // 1
//    [p release]; // 2B
    
    return 0;
}
