//
//  main.m
//  self关键字
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Iphone.h"

int main(int argc, const char * argv[]) {
    // self不能离开类, 离开类之后没有任何意义
    
    [Iphone carameWithFlahlightStatus:kFlahlightStatusClose];
    return 0;
}
