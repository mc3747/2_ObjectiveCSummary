//
//  ZFButton.h
//  RHPlacePick
//
//  Created by gjfax on 2019/2/28.
//  Copyright © 2019 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    ZFButtonTypeCenterImageCenterTitle,//图片，文字都居中
    ZFButtonTypeRightImageLeftTitle,//图片右，文字左
    ZFButtonTypeLeftImageNoneTitle,//图片左，文字无
} ZFButtonType;

NS_ASSUME_NONNULL_BEGIN

@interface ZFButton : UIButton
@property (nonatomic, assign) ZFButtonType type;
+ (instancetype)zfButtonWithType:(ZFButtonType)buttonType;

- (void)updateButtonStyleWithType:(ZFButtonType)buttonType;
@end

NS_ASSUME_NONNULL_END
