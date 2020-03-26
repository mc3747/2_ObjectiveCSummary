//
//  SKLoopCreateViews.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/5/11.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKLoopCreateViews.h"

@interface SKLoopCreateViews(){
    NSArray *_cells;
}

/**
 *  finalNumber
 */
@property (nonatomic, assign) NSInteger finalNumber;

@end
@implementation SKLoopCreateViews



- (instancetype)init {
    if (self = [super init]) {
        [self createViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self createViews];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //这个会调用updateConstraints
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}
- (void)createViews {
    NSMutableArray *cells = [NSMutableArray array];
    
    NSInteger count = 5;
    for (NSInteger i = 0; i < count; i++)
    {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithRed: i/10.0 green:i/10.0 blue:i/10.0 alpha:1];
        [self addSubview:view];
        [cells addObject:view];
    }
    _cells = cells;
}


- (void)updateConstraints {
    [self setupviews];
    [super updateConstraints];
}
#warning 横竖屏切换会有冲突原因是因为横竖屏计算gap的时候横屏计算的是3 竖屏计算的是4 所以两个约束gap不一样会产生冲突。
-(void)setupviews {
    //宽
    CGFloat cellWidth = 70;
    //一行有几个
    NSInteger countPerRow = self.bounds.size.width/cellWidth;
    // 视图间隙
    CGFloat gap = (self.bounds.size.width -  cellWidth * countPerRow) / (countPerRow + 1);
    NSUInteger count = _cells.count;
    //通过这个控制是否是最后一行
    if (count%countPerRow == 0) {
        self.finalNumber = countPerRow*(count/countPerRow -1) + 1;
    } else {
        self.finalNumber = count/countPerRow *countPerRow + 1;
    }
    for (NSUInteger i = 0; i < count; i++)
    {
        UIView *cell =  [_cells objectAtIndex:i];
        NSInteger row = i / countPerRow;
        NSInteger column = i % countPerRow;
        [cell mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(row * (gap + cellWidth) + gap));
            make.left.equalTo(@(column * (gap + cellWidth) + gap));
            make.width.equalTo(@(cellWidth));
            make.height.equalTo(@(cellWidth));
            //如果是最后一行
            if (i >=self.finalNumber -1) {
                make.bottom.mas_equalTo(-5);
            }
            if ((i+1)%countPerRow == 0) {
                make.right.mas_lessThanOrEqualTo(-gap);
            }
        }];
    }
}


@end
