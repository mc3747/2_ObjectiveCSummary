//
//  UIButton+layout.m
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2019/12/17.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "UIButton+layout.h"


@implementation UIButton (layout)
- (void)layoutWithStyle:(LYButtonLayoutStyle)style andSpacing:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    switch (style) {
        case LYButtonLayoutStyleImagePositionTop: {
            self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing) / 2, titleSize.width / 2, (titleSize.height + spacing) / 2, -(titleSize.width / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake((imageSize.height + spacing) / 2, -(imageSize.width / 2), -(imageSize.height + spacing) / 2, imageSize.width / 2);
        }
            break;
            
        case LYButtonLayoutStyleImagePositionBottom: {
            self.imageEdgeInsets = UIEdgeInsetsMake((titleSize.height + spacing) / 2, titleSize.width / 2, -(titleSize.height + spacing) / 2, -(titleSize.width / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height + spacing) / 2, -(imageSize.width / 2), (imageSize.height + spacing) / 2, imageSize.width / 2);
        }
            break;
            
        case LYButtonLayoutStyleImagePositionLeft: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -(spacing / 2), 0.0, spacing / 2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, spacing / 2, 0.0, -(spacing / 2));
        }
            break;
            
        case LYButtonLayoutStyleImagePositionRight: {
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing / 2, 0.0, -(titleSize.width + spacing / 2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -(imageSize.width + spacing / 2), 0.0, (imageSize.width + spacing / 2));
        }
            break;
        default:
            break;
    }
}
@end
