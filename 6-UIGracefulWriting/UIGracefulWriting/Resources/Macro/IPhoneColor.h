//
//  IPhoneColor.h
//  UIGracefulWriting
//
//  Created by gjfax on 2018/9/27.
//  Copyright © 2018年 macheng. All rights reserved.
//

#ifndef IPhoneColor_h
#define IPhoneColor_h

#import "UIColor+Wonderful.h"

// RGB颜色
#define LBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// RGBA颜色
#define LBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 16进制颜色
#define LBColorFromRGBHex(rgbValue) [UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
    blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 随机色
#define LBRandomColor LBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 主题色
#define MainColor [UIColor colorWithRed:1.000 green:0.580 blue:0.302 alpha:1.000];

#endif /* IPhoneColor_h */
