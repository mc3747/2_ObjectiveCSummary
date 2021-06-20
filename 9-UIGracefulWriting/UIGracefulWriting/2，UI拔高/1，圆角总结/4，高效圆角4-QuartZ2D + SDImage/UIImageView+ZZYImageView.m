//
//  UIImageView+ZZYImageView.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/5/20.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "UIImageView+ZZYImageView.h"
#import <UIImageView+WebCache.h>
#import "UIImage+ZZYCircleImage.h"

@implementation UIImageView (ZZYImageView)
- (void)setCircleImage:(NSString *)imageUrl withPlaceholderImage:(NSString *)placeholderImageName
{
    UIImage * placeholderImage = [UIImage imageNamed:placeholderImageName];
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage]:[placeholderImage circleImage];
    }];
}


@end
