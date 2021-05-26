//
//  MJPerson.m
//  Interview01-位运算
//
//  Created by MJ Lee on 2018/5/19.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MJPerson.h"

@implementation MJPerson
- (void)setOptions:(MJOptions)options
{
    if (options & MJOptionsOne) {
        NSLog(@"包含了MJOptionsOne");
    }
    
    if (options & MJOptionsTwo) {
        NSLog(@"包含了MJOptionsTwo");
    }
    
    if (options & MJOptionsThree) {
        NSLog(@"包含了MJOptionsThree");
    }
    
    if (options & MJOptionsFour) {
        NSLog(@"包含了MJOptionsFour");
    }
}
@end
