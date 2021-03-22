//
//  MCBannerScrollView.m
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2018/5/22.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "CustomBannerScrollView.h"

//素材图片的宽度
static float const pictureWidth = 207.f;

//素材图片的高度
static float const pictureHeighth = 123.f;

//图片距离边距
static float const gapToSuper = 10.f;

//图片之间的间距
static float const gapBetween = 2.f;

@interface CustomBannerScrollView()
@property (nonatomic, strong) NSArray *picturesArray;
@end

@implementation CustomBannerScrollView

- (void)configPictures:(NSArray *)picturesArray {
    if (!_picturesArray) {
        _picturesArray = picturesArray;
    }
// scrollView设置
    self.backgroundColor = [UIColor clearColor];
    self.scrollEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    if (picturesArray.count == 0) {
        return;
    }
    
// 实际图片的宽度
    CGFloat realPictureWidth = pictureWidth * self.frame.size.height / pictureHeighth;
    CGFloat realPictureHeighth = self.frame.size.height;
    
// 距离边界的距离
    CGFloat gapFloat;
     if (((gapToSuper  + gapBetween) * (picturesArray.count - 1) + realPictureWidth * picturesArray.count) >= self.frame.size.width) {
         gapFloat = gapToSuper;
         
     } else {
         gapFloat =  (self.frame.size.width - realPictureWidth * picturesArray.count - gapBetween * (picturesArray.count - 1)) * 0.5f;
     };

//添加图片
    if (_picturesArray.count != picturesArray.count) {
         [self removeAllSubviews];
        
    } else if (![self compareArray:_picturesArray withArray:picturesArray]) {
        [self removeAllSubviews];
        
    } else if(self.subviews.count <= 0){
        [self removeAllSubviews];
        
    } else {
        return;
    };


    for (int i = 0; i < picturesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(gapFloat + (realPictureWidth + gapBetween) * i, 0, realPictureWidth, realPictureHeighth)];
        imageView.image = [UIImage imageNamed:picturesArray[i]];
        [self addSubview:imageView];
    };
 
    
//设置滚动宽度
    self.contentSize = CGSizeMake(gapBetween * (picturesArray.count - 1) + realPictureWidth * picturesArray.count + gapFloat * 2, self.frame.size.height);
    
}

#pragma mark -  判断两个数组的元素是否相等
- (BOOL)compareArray:(NSArray *)oneArray withArray:(NSArray *)twoArray {
    if (oneArray.count != twoArray.count) {
        return NO;
    };
    
    for (int i = 0; i < oneArray.count; i ++) {
        if (oneArray[i] != twoArray[i]) {
            return NO;
            break;
        };
    }
    
    return YES;
}

#pragma mark -  移除所有子元素
- (void)removeAllSubviews {
    
    NSArray *viewsToRemove = [self subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    //或者
    //    [[self subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
