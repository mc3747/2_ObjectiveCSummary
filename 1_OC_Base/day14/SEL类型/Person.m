//
//  Person.m
//  day14
//
//  Created by 李南江 on 15/6/20.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)test
{
    NSLog(@"test");
}

- (void)demo
{
    NSLog(@"demo");
}

- (void)signalWithNumber:(NSString *)number
{
    NSLog(@"number = %@", number);
}

- (void)sendMessageWithNumber:(NSString *)number andContetn:(NSString *)content
{
    NSLog(@"number = %@, content = %@", number, content);
}

- (void)makeObject:(id)obj andSel:(SEL)sel
{
    [obj performSelector:sel];
}
@end
