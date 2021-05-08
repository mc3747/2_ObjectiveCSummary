//
//  main.m
//  对象作为返回值类型
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 弹夹
@interface Clip : NSObject
{
@public
    int _bullet; // 子弹
}

// 上子弹的方法
- (void)addBullet;

@end

@implementation Clip

- (void)addBullet
{
    // 上子弹
    _bullet = 10;
}

@end

#pragma mark - 枪
@interface Gun : NSObject
{
    Clip *clip; // 弹夹
}

// 射击
// 注意: 在企业级开发中千万不要随意修改一个方法
- (void)shoot:(Clip *)c;
@end

@implementation Gun

- (void)shoot:(Clip *)c
{
    // 判断有没有弹夹
    if (c != nil) { // nil == null == 没有值
        // 判断有没有子弹
        if (c->_bullet > 0) {
            c->_bullet -= 1;
            NSLog(@"打了一枪 %i", c->_bullet);
        }else
        {
            NSLog(@"没有子弹了");
        }
    }else
    {
        NSLog(@"没有弹夹, 请换弹夹");
    }
}
@end

#pragma mark - 士兵
@interface Soldier : NSObject
{
@public
    NSString *_name;
    double _height;
    double _weight;
}
// 开火
- (void)fire:(Gun *)gun;

// 开火, 给士兵一把枪和一个弹夹
- (void)fire:(Gun *)gun clip:(Clip *)clip;
@end

@implementation Soldier

- (void)fire:(Gun *)g
{
    [g shoot];
}

- (void)fire:(Gun *)gun clip:(Clip *)clip
{
    // 判断是否有枪和子弹
    if (gun !=nil &&
        clip != nil) {
        
        [gun shoot:clip];
    }
}

@end

#pragma mark - 商店
@interface Shop : NSObject

// 买枪
+ (Gun *)buyGun:(int)monery;

// 买弹夹
+ (Clip *)buyClip:(int)monery;
@end

@implementation Shop


+ (Gun *)buyGun:(int)monery
{
    // 1.创建一把枪
    Gun *gun = [Gun new]; // 通过new创建出来的对象存储在堆中, 堆中的数据不会自动释放
    // 2.返回一把枪
    return gun;
}
+ (Clip *)buyClip:(int)monery
{
    Clip *clip = [Clip new];
    [clip addBullet];
    return clip;
}

@end

#pragma mark - 程序入口
int main(int argc, const char * argv[]) {
    
    // 1.创建士兵
    Soldier *sp =[Soldier new];
    sp->_name = @"屎太浓";
    sp->_height = 1.88;
    sp->_weight = 100.0;
    
    // 2.创建一把枪
//    Gun *gp = [Gun new];
    
//    Shop *shop = [Shop new];
    // 2.购买手枪
    Gun *gp = [Shop buyGun:888];
    
    // 3.创建弹夹
//    Clip *clip = [Clip new];
//    [clip addBullet];
    
    // 3.购买弹夹
    Clip *clip = [Shop buyClip:100];
    
    // 4.让士兵开枪
    [sp fire:gp clip:clip];
    
    return 0;
}
