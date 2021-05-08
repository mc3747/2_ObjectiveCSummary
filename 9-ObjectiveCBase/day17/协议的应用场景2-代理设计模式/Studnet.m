//
//  Studnet.m
//  day17
//
//  Created by xiaomage on 15/6/28.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Studnet.h"
#import "Baby.h"

@implementation Studnet
- (void)feedFood:(Baby *)baby
{
    baby.hungry -= 10;
    NSLog(@"喂婴儿吃东西 %i", baby.hungry);
}

- (void)hongBaby:(Baby *)baby
{
    baby.sleep += 10;
    NSLog(@"哄婴儿睡觉 %i", baby.sleep);
}
@end
