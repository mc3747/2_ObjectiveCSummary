//
//  main.m
//  super
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Iphone.h"


int main(int argc, const char * argv[]) {

    Iphone *p = [Iphone new];
    [p test];
    [Iphone carameWithFlahlightStatus:kFlahlightStatusOpen];
    
    return 0;
}
