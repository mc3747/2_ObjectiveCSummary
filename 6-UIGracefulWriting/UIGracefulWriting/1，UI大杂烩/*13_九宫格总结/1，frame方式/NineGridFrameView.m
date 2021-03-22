//
//  NineGridFrameView.m
//  UIGracefulWriting
//
//  Created by gjfax on 2018/10/30.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "NineGridFrameView.h"

// 列数(自定义)
#define COL_COUNT 4

// 左右间距
#define COL_GAP 5

// 上下间距
#define ROW_GAP 15

@interface NineGridFrameView()
@property (nonatomic, assign) CGFloat gridWidth;
@property (nonatomic, assign) CGFloat gridHeight;
@end

@implementation NineGridFrameView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    if (self = [super initWithFrame:frame]) {
        if (imageArray.count > 0) {
            _gridWidth = (frame.size.width - (COL_COUNT + 1) * COL_GAP) / COL_COUNT;
            NSInteger rowCount = imageArray.count / COL_COUNT;
            _gridHeight = (frame.size.height - (rowCount + 1) * ROW_GAP) / rowCount;
        };
        
        [self addPictures:imageArray];
    }
    return self;
}

/** 九宫格形式添加图片 */
- (void)addPictures:(NSArray *)imageArray {
    // 在for循环中添加
    // pictures.count中的pictures是一个图片数组，代表着要添加多少个图片
    for (int i = 0; i < imageArray.count; i++) {
        //创建图片
        UIView *view = [[UIView alloc] init];
        UIImage *image = [UIImage imageNamed:imageArray[i]];
        //view的背景显示图片
        view.layer.contents = (__bridge id)(image.CGImage);
        view.layer.backgroundColor = LBRandomColor.CGColor;
        
        // 图片所在行
        NSInteger row = i / COL_COUNT;
        // 图片所在列
        NSInteger col = i % COL_COUNT;
        // 间距
        CGFloat margin = (self.bounds.size.width - (_gridWidth * COL_COUNT)) / (COL_COUNT + 1);
        // PointX
        CGFloat picX = margin + (_gridWidth + margin) * col;
        // PointY
        CGFloat picY = margin + (_gridHeight + margin) * row;
        
        view.frame = CGRectMake(picX, picY, _gridWidth, _gridHeight);
        GJWeakSelf
        [view GJSHandleClick:^(UIView *view) {
            if (weakSelf.indexPathBlock) {
                weakSelf.indexPathBlock(FMT_STR(@"%li",row), FMT_STR(@"%li",col));
            }
                    }];
        [self addSubview:view];
    }
}


@end
