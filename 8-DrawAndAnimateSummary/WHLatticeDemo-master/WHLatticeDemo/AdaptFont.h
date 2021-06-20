//
//  AdaptFont.h
//  WHLatticeDemo
//
//  Created by gjfax on 2019/5/11.
//  Copyright © 2019 remember17. All rights reserved.
//

#ifndef AdaptFont_h
#define AdaptFont_h

//方法1：用宏定义适配字体大小（根据屏幕尺寸判断）
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define FONT_SIZE(size) ([UIFont systemFontOfSize:FontSize(size))

/**
 *  字体适配 我在PCH文件定义了一个方法
 */
static inline CGFloat FontSize(CGFloat fontSize){
    if (SCREEN_WIDTH==320) {
        return fontSize-2;
    }else if (SCREEN_WIDTH==375){
        
        return fontSize;
    }else{
        return fontSize+2;
    }
}
//方法2：用宏定义适配字体大小（根据屏幕尺寸判断）
#define IsIphone6P          SCREEN_WIDTH==414
#define SizeScale           (IsIphone6P ? 1.5 : 1)
#define kFontSize(value)    value*SizeScale
#define kFont(value)        [UIFont systemFontOfSize:value*SizeScale]

//方法3：UIFont写个分类

//方法4：控件写分类

#endif /* AdaptFont_h */
