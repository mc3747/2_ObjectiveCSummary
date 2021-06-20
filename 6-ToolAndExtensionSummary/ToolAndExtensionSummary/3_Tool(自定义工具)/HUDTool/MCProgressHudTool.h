//
//  MCProgressHudTool.h
//  SmartMedicalPlatformIM
//
//  Created by gjfax on 2019/3/19.
//  Copyright © 2019 SevenShare. All rights reserved.
//

#import "MBProgressHUD.h"
//#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, YJProgressHUDStatus) {
    
    /** 成功 */
    YJProgressHUDStatusSuccess,
    
    /** 失败 */
    YJProgressHUDStatusError,
    
    /** 警告*/
    YJProgressHUDStatusWaitting,
    
    /** 提示 */
    YJProgressHUDStatusInfo,
    
    /** 等待 */
    YJProgressHUDStatusLoading
    
};

@interface MCProgressHudTool : MBProgressHUD

/**
 *  是否正在显示
 */
@property (nonatomic, assign, getter=isShowNow) BOOL showNow;

/** 返回一个 HUD 的单例 */
+ (instancetype)sharedHUD;

/** 在 window 上添加一个 HUD */
+ (void)showStatus:(YJProgressHUDStatus)status text:(NSString *)text;



#pragma mark - 建议使用的方法

/** 在 window 上添加一个只显示文字的 HUD */
+ (void)showMessage:(NSString *)text;

/** 在 window 上添加一个提示`信息`的 HUD */
+ (void)showWaiting:(NSString *)text;

/** 在 window 上添加一个提示`失败`的 HUD */
+ (void)showError:(NSString *)text;

/** 在 window 上添加一个提示`成功`的 HUD */
+ (void)showSuccess:(NSString *)text;

/** 在 window 上添加一个提示`等待`的 HUD, 需要手动关闭 */
+ (void)showLoading:(NSString *)text;

/** 手动隐藏 HUD */
+ (void)hideHUD;
@end

NS_ASSUME_NONNULL_END
