//
//  CommonColorDefine.h
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2018/5/18.
//  Copyright © 2018年 macheng. All rights reserved.
//

#ifndef CommonColorDefine_h
#define CommonColorDefine_h

// 基础颜色
#define BaseColorClear                [UIColor clearColor]
#define BaseColorWhite                [UIColor whiteColor]
#define BaseColorBlack                [UIColor blackColor]
#define BaseColorGray                 [UIColor grayColor]
#define BaseColorRed                  [UIColor redColor]
#define BaseColorGreen                [UIColor greenColor]
#define BaseColorBlue                 [UIColor blueColor]
#define BaseColorYellow               [UIColor yellowColor]

//  RGB颜色值
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//  RGBA颜色值
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

// 十六进制RGB颜色值
#define RGBHex(rgbHexValue)     [UIColor \
colorWithRed:((float)((rgbHexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbHexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbHexValue & 0xFF))/255.0 alpha:1.0]

// 十六进制RGBA颜色值
#define RGBAHex(rgbHexValue,a)     [UIColor \
colorWithRed:((float)((rgbHexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbHexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbHexValue & 0xFF))/255.0 alpha:a]

//  随机颜色
#define RandColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


// 定制的颜色（自己喜欢😍的颜色）
//浅灰色
#define MCColorLightGray           RGBHex(0xC0C0C0)
//象牙黑
#define MCColorLightBlack          RGBHex(0x292421)
//白杏仁色
#define MCColorLightYellow         RGBHex(0xFFFFCD)
//天蓝色
#define MCColorLightBlue           RGBHex(0xF0FFFF)
//珊瑚橙
#define MCColorLightOrange         RGBHex(0xFF7F50)
//薄荷色
#define MCColorLightGreen          RGBHex(0xBDFCC9)
//梅红色
#define MCColorLightRed            RGBHex(0xDDA0DD)

#endif /* CommonColorDefine_h */
