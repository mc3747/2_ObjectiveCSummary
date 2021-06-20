//
//  MNCameraController.h
//  MNKit
//
//  Created by Vincent on 2019/6/12.
//  Copyright © 2019 Vincent. All rights reserved.
//  资源获取<视频录制/拍照>

#import "MNBaseViewController.h"
@class MNCameraController, MNAssetPickConfiguration;

@protocol MNCameraControllerDelegate <NSObject>
@optional;
- (void)cameraControllerDidCancel:(MNCameraController *)cameraController;
- (void)cameraController:(MNCameraController *)cameraController didFinishWithVideoOfPath:(NSString *)filePath;
- (void)cameraController:(MNCameraController *)cameraController didFinishWithStillImage:(UIImage *)image;
- (void)cameraController:(MNCameraController *)cameraController didFinishWithContents:(id)contents;
@end

@interface MNCameraController : MNBaseViewController

@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, weak) id<MNCameraControllerDelegate> delegate;

@property (nonatomic, strong) MNAssetPickConfiguration *configuration;

@end
