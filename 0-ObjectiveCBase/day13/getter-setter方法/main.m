//
//  main.m
//  getter-setter方法
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gun.h"

int main(int argc, const char * argv[]) {

    Gun *gun = [Gun new];
    [gun setColor:1];
    NSLog(@"color = %i", [gun color]);
    return 0;
}
