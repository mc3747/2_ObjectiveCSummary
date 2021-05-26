//
//  MJPerson.m
//  Interview01-Runtime
//
//  Created by MJ Lee on 2018/5/17.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import "MJPerson.h"

// 🌈按位与&可以用来取出特定的位
// 0000 0111
//&0000 0100
//------
// 0000 0100

// 🌈按位或|可以用来设置特定的位
// 0000 0011
//|0000 0100
//------
// 0000 0111


// 掩码，一般用来按位与(&)运算的
//#define MJTallMask 1
//#define MJRichMask 2
//#define MJHandsomeMask 4

//#define MJTallMask 0b00000001
//#define MJRichMask 0b00000010
//#define MJHandsomeMask 0b00000100

#define MJTallMask (1<<0)
#define MJRichMask (1<<1)
#define MJHandsomeMask (1<<2)

@interface MJPerson()
{
    char _tallRichHansome;
}
@end

@implementation MJPerson

- (instancetype)init
{
    if (self = [super init]) {
        _tallRichHansome = 0b00000100;
    }
    return self;
}

- (void)setTall:(BOOL)tall
{
    if (tall) {
        _tallRichHansome |= MJTallMask;
    } else {
        _tallRichHansome &= ~MJTallMask;
    }
}

- (BOOL)isTall
{
//    可以用Bool强转，也可以用两个！！，将整型转成布尔型
    return !!(_tallRichHansome & MJTallMask);
}

- (void)setRich:(BOOL)rich
{
    if (rich) {
        _tallRichHansome |= MJRichMask;
    } else {
        _tallRichHansome &= ~MJRichMask;
    }
}

- (BOOL)isRich
{
    return !!(_tallRichHansome & MJRichMask);
}

- (void)setHandsome:(BOOL)handsome
{
    if (handsome) {
        _tallRichHansome |= MJHandsomeMask;
    } else {
        _tallRichHansome &= ~MJHandsomeMask;
    }
}

- (BOOL)isHandsome
{
    return !!(_tallRichHansome & MJHandsomeMask);
}

@end
