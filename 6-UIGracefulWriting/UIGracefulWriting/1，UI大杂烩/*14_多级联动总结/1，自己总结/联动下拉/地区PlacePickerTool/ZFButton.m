//
//  ZFButton.m
//  RHPlacePick
//
//  Created by gjfax on 2019/2/28.
//  Copyright © 2019 Abner_G. All rights reserved.
//

#import "ZFButton.h"

@implementation ZFButton
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.type == ZFButtonTypeCenterImageCenterTitle) {
        [self resetBtnCenterImageCenterTitle];
        
    } else if (self.type == ZFButtonTypeLeftImageNoneTitle) {
        [self resetBtnLeftImageNotTitle];
        
    } else if (self.type == ZFButtonTypeRightImageLeftTitle) {
        [self resetBtnRightImageLeftTitle];
    }
}

+ (instancetype)zfButtonWithType:(ZFButtonType)buttonType {
    
    ZFButton * btn = [ZFButton buttonWithType:UIButtonTypeCustom];
    [btn updateButtonStyleWithType:buttonType];
    return btn;
}

- (void)updateButtonStyleWithType:(ZFButtonType)buttonType {
    
    self.type = buttonType;
    [self layoutSubviews];
}

#pragma mark -  左image + 右title
- (void)resetBtnCenterImageCenterTitle {
    
    self.imageView.frame = self.bounds;
    [self.imageView setContentMode:UIViewContentModeRight];
    
    self.titleLabel.frame = self.bounds;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}
#pragma mark -  image
- (void)resetBtnLeftImageNotTitle {
    
    CGRect frame = self.bounds;
    frame.size.width *= 0.5;
    self.imageView.frame = frame;
    [self.imageView setContentMode:UIViewContentModeRight];
    
    self.titleLabel.frame = CGRectZero;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}
#pragma mark -  左title + 右image
- (void)resetBtnRightImageLeftTitle {
    
    CGRect titleFrame = self.bounds;
//    titleFrame.origin.x = 15;
    titleFrame.size.width = titleFrame.size.width * 0.7;
    titleFrame.size.height = self.bounds.size.height;
    self.titleLabel.frame = titleFrame;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
   
    
    CGRect imageFrame = self.bounds;
    imageFrame.origin.x = self.bounds.size.width * 0.7;
    imageFrame.size.width = self.bounds.size.width * 0.3;
    imageFrame.size.height = self.bounds.size.height;
    self.imageView.frame = imageFrame;
    [self.imageView setContentMode:UIViewContentModeRight];
}

@end
