//
//  main.m
//  self关键字2
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Iphone.h"

int main(int argc, const char * argv[]) {
    
    Iphone *p = [Iphone new];
    NSLog(@"p = %p", p);
    [p carameWithFlahlightStatus:kFlahlightStatusOpen];
    
    return 0;
}
