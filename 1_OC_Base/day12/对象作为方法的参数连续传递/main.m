//
//  main.m
//  对象作为方法的参数连续传递
//
//  Created by xiaomage on 15/6/18.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 士兵
 事物名称: 士兵(Soldier)
 属性:姓名(name), 身高(height), 体重(weight)
 行为:打枪(fire), 打电话(callPhone)
 
 枪
 事物名称:枪(Gun)
 属性:弹夹(clip) , 型号(model)
 行为:上弹夹(addClip)
 
 弹夹
 事物名称: 弹夹(Clip)
 属性:子弹(Bullet)
 行为:上子弹(addBullet)
 */

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
//@public
//    int _bullet; // 子弹
    Clip *clip; // 弹夹
}

// 射击
// 注意: 在企业级开发中千万不要随意修改一个方法
- (void)shoot;

// 想要射击必须传递一个弹夹
- (void)shoot:(Clip *)c;
@end

@implementation Gun
/*
- (void)shoot
{
    // 判断是否有子弹
    if (_bullet > 0) {
        
        _bullet--;
        NSLog(@"打了一枪 %i", _bullet);
    }else
    {
        NSLog(@"没有子弹了, 请换弹夹");
    }
}
 */

/**
*  射击
*
*  @param c 弹夹
*/
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

#pragma mark - 程序入口
int main(int argc, const char * argv[]) {
    
    // 1.创建士兵
    Soldier *sp =[Soldier new];
    sp->_name = @"屎太浓";
    sp->_height = 1.88;
    sp->_weight = 100.0;
    
    // 2.创建一把枪
    Gun *gp = [Gun new];
//    gp->_bullet = 10;
    
    // 3.创建弹夹
    Clip *clip = [Clip new];
    [clip addBullet];
    
    // 2.让士兵开枪
    // 让对象作为方法的参数传递
//    [sp fire:gp]; // 地址
    [sp fire:gp clip:clip];
    
    return 0;
}
