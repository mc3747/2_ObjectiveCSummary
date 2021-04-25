//
//  main.m
//  继承的其他特性
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Iphone.h"

int main(int argc, const char * argv[]) {
    
    Iphone *p = [Iphone new];
    [p signalWithNumber:@"13456789"];
    
    [Iphone brand];
    /*
     继承:
     当B类继承A类, 那么B类就拥有A类所有的属性和方法(类方法/对象方法)
     
     优点:
     提高代码的复用性
     可以让类与类之间产生关系, 正是因为继承让类与类之间产生了关系所以才有了多态
     
     注意: 
     不要以为继承可以提高代码的复用性, 以后但凡发现多个类当中有重复代码就抽取一个父类
     只要满足一定的条件我们才能使用继承
     条件: XXXX 是 XXX   /    某某某 is a 某某某
     
     学生:
     姓名
     年龄
     数学成绩
     语文成绩
     英语成绩
     
     排行榜:
     数学成绩
     语文成绩
     英语成绩
     
     分数类:
     数学成绩
     语文成绩
     英语成绩
     
     缺点:
     耦合性太强(依赖性太强)
     
     */
    return 0;
}
