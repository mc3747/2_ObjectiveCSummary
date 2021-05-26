//
//  MJPerson.h
//  Interview01-位运算
//
//  Created by MJ Lee on 2018/5/19.
//  Copyright © 2018年 MJ Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
//    MJOptionsNone = 0,    // 0b0000
    MJOptionsOne = 1<<0,   // 0b0001
    MJOptionsTwo = 1<<1,   // 0b0010
    MJOptionsThree = 1<<2, // 0b0100
    MJOptionsFour = 1<<3   // 0b1000
} MJOptions;
@interface MJPerson : NSObject
@property(assign,nonatomic)MJOptions options;


@end
