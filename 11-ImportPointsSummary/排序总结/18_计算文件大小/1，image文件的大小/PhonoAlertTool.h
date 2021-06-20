//
//  PhonoAlertTool.h
//  排序总结
//
//  Created by gjfax on 2018/11/13.
//  Copyright © 2018 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^didSelectedWithImageBlock)(UIImage *image,CGFloat imageBytes);
NS_ASSUME_NONNULL_BEGIN

@interface PhonoAlertTool : NSObject

+ (void)showInView:(UIViewController *)controller imageBlock:(didSelectedWithImageBlock)block;
- (void)showInView:(UIViewController *)controller imageBlock:(didSelectedWithImageBlock)block;
@end

NS_ASSUME_NONNULL_END
