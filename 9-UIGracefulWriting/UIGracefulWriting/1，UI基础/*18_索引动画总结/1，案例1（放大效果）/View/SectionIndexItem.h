//
//  SectionIndexItem.h
//  TSCustomTableViewIndexs
//
//  Created by lujh on 2017/9/5.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import <UIKit/UIKit.h>
// =====================================================
/*
 每一个字母view
 */
// =====================================================
@interface SectionIndexItem : UIView
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;//方便在子类里重写该方法
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
@end
