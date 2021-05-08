//
//  main.m
//  @class第二个应用场景
//
//  Created by xiaomage on 15/6/24.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {

    Person *p = [Person new];
    Dog *d = [Dog new];
    
    p.dog = d;
    
    [p release];
    [d release];
    
    return 0;
}
