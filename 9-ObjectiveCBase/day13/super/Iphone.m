//
//  Iphone.m
//  day13
//
//  Created by xiaomage on 15/6/19.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//


#import "Iphone.h"

@implementation Iphone

+ (void)carameWithFlahlightStatus:(FlahlightStatus)status
{
    NSLog(@"聚焦");
    NSLog(@"调光");
    NSLog(@"人脸识别");
    
    /*
    // 由于以下代码和父类中的一模一样, 所以只需调用父类写好的代码即可
    if (status == kFlahlightStatusOpen) {
        [self openFlahlight];
    }else
    {
        [self closeFlahlight];
    }
    NSLog(@"拍照");
     */
//    [self carameWithFlahlightStatus:status];
    // 只需要利用super给父类的方法发送一个消息, 那么系统就会自动调用父类的方法
    // 如果以后想在子类中调用父类的方法可以使用super
    // 如果想在给父类方法进行扩展的同时保留父类的方法, 那么可以使用super调用父类同名的方法
    [super carameWithFlahlightStatus:status];
}

- (void)test
{
    /*
     super在类方法中, 一定会调用父类的类方法
     super在对象方法中, 一定会调用父类的对象方法
     可以利用super在任意方法中调用父类中的方法
     */
    [super carameWithFlahlightStatus:kFlahlightStatusOpen];
}
@end
