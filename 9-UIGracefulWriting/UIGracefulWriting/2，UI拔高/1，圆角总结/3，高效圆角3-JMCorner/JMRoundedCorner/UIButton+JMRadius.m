//
//  UIButton+JMRadius.m
//  JMRoundedCornerDemo
//
//  Created by 饶志臻 on 2016/10/9.
//  Copyright © 2016年 饶志臻. All rights reserved.
//

#import "UIButton+JMRadius.h"
#if __has_include(<YYWebImage/UIButton+YYWebImage.h>)
#import <YYWebImage/UIButton+YYWebImage.h>
#else
#import "UIButton+YYWebImage.h"
#endif


@implementation UIButton (JMRadius)

- (void)jm_setImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:JMRadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    [self jm_setImageWithJMRadius:radius imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size forState:(UIControlState)state];
}

- (void)jm_setImageWithJMRadius:(JMRadius)radius imageURL:(NSURL *)imageURL placeholder:(UIImage *)placeholder borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size forState:(UIControlState)state {
    
    NSString *transformKey =  [NSString stringWithFormat:@"%@%@%.1f%@%li%@", NSStringFromJMRadius(radius), borderColor.description, borderWidth, backgroundColor.description, (long)contentMode,NSStringFromCGSize(size)];
    NSString *transformImageKey = [[YYWebImageManager sharedManager] cacheKeyForURL:imageURL];
    UIImage *cacheImage = [[YYWebImageManager sharedManager].cache getImageForKey:transformImageKey];
    
    if (cacheImage) {
        [self setImage:cacheImage forState:state];
        return;
    }
    
    NSString *imageKey = [[YYWebImageManager sharedManager] cacheKeyForURL:imageURL];
    cacheImage = [[YYWebImageManager sharedManager].cache getImageForKey:imageKey];
    
    if (cacheImage) {
        cacheImage = [UIImage jm_setJMRadius:radius image:cacheImage size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
        [self setImage:cacheImage forState:state];
        return;
    }
    
    UIImage *placeholderImage;
    if (placeholder || borderWidth > 0 || backgroundColor) {
        placeholderImage = [[YYWebImageManager sharedManager].cache getImageForKey:transformKey];
        if (!placeholderImage) {
            placeholderImage = [UIImage jm_setJMRadius:radius image:placeholder size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
            [[YYWebImageManager sharedManager].cache setImage:placeholderImage forKey:transformKey];
        }
    }
    [self setImageWithURL:imageURL forState:state placeholder:placeholderImage options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        [[YYWebImageManager sharedManager].cache setImage:image forKey:imageKey];
                UIImage *currentImage = [UIImage jm_setJMRadius:radius image:image size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                return currentImage;
    } completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
//    [self yy_setImageWithURL:imageURL forState:state placeholder:placeholderImage options:kNilOptions progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
//        [[YYWebImageManager sharedManager].cache setImage:image forKey:imageKey];
//        UIImage *currentImage = [UIImage jm_setJMRadius:radius image:image size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
//        return currentImage;
//    } transformKey:transformKey completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//    }];
}

@end
