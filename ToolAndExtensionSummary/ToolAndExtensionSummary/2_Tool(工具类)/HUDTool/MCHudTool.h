//
//  ChaosStatusBarHUD.h
//  SmartMedicalPlatformIM
//
//  Created by gjfax on 2019/3/11.
//  Copyright © 2019 SevenShare. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCHudTool : NSObject
/** 显示成功信息 */
+ (void)showSuccess:(NSString *)str;
/** 显示失败信息 */
+ (void)showError:(NSString *)str;
/** 显示正在加载的信息 */
+ (void)showLoading:(NSString *)str;
/** 隐藏 */
+ (void)hide;
/** 显示纯文本 */
+ (void)showMessage:(NSString *)str;
/** 自定义图标 文字 */
+ (void)showMessage:(NSString *)str withImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
