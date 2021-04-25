//
//  main.m
//  SEL类型
//
//  Created by 李南江 on 15/6/20.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Car.h"

int main(int argc, const char * argv[]) {
    
    // 1.SEL类型的第一个作用, 配合对象/类来检查对象/类中有没有实现某一个方法
    /*
    SEL sel = @selector(setAge:);
    Person *p = [Person new];
    // 判断p对象中有没有实现-号开头的setAge:方法
    // 如果P对象实现了setAge:方法那么就会返回YES
    // 如果P对象没有实现setAge:方法那么就会返回NO
    BOOL flag = [p respondsToSelector:sel];
    NSLog(@"flag = %i", flag);
    
    // respondsToSelector注意点: 如果是通过一个对象来调用该方法那么会判断该对象有没有实现-号开头的方法
    // 如果是通过类来调用该方法, 那么会判断该类有没有实现+号开头的方法
    SEL sel1 = @selector(test);
    flag = [p respondsToSelector:sel1];
    NSLog(@"flag = %i", flag);
    
    flag = [Person respondsToSelector:sel1];
    NSLog(@"flag = %i", flag);
     */
    
    /*
    // 2.SEL类型的第二个作用, 配合对象/类来调用某一个SEL方法
    SEL sel = @selector(demo);
    Person *p = [Person new];
    // 调用p对用中sel类型对应的方法
    [p performSelector:sel];
    
    SEL sel1 = @selector(signalWithNumber:);
    // withObject: 需要传递的参数
    // 注意: 如果通过performSelector调用有参数的方法, 那么参数必须是对象类型,
    // 也就是说方法的形参必须接受的是一个对象, 因为withObject只能传递一个对象
    [p performSelector:sel1 withObject:@"13838383438"];
    
    SEL sel2 = @selector(setAge:);
    [p performSelector:sel2 withObject:@(5)];
    NSLog(@"age = %i", p.age);
    
    // 注意:performSelector最多只能传递2个参数
    SEL sel3 = @selector(sendMessageWithNumber:andContetn:);
    [p performSelector:sel3 withObject:@"138383438" withObject:@"abcdefg"];
     */
    
    // 3. 
    Car *c = [Car new];
    SEL sel = @selector(run);
    
    Person *p = [Person new];
    [p makeObject:c andSel:sel];
    return 0;
}
