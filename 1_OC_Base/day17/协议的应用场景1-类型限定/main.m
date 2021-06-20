//
//  main.m
//  协议的应用场景1-类型限定
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Wife.h"
#import "WifeCondition.h"

int main(int argc, const char * argv[]) {

    Person *p = [Person new];
    // 1.协议的第一个应用场景, 可以将协议写在数据类型的右边, 明确的标注如果想给该变量赋值, 那么该对象必须遵守某个协议
//    Wife<WifeCondition> *w = [Wife new];
    Wife *w = [Wife new];
    p.wife = w;
    
    [p show];
    
    return 0;
}
