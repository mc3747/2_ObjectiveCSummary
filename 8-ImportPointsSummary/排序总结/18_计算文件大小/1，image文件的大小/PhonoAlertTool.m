//
//  PhonoAlertTool.m
//  排序总结
//
//  Created by gjfax on 2018/11/13.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "PhonoAlertTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
@interface PhonoAlertTool() <UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, weak) UIViewController               *VC;
@property (nonatomic, copy) didSelectedWithImageBlock      imageBlock;
@end

@implementation PhonoAlertTool
#pragma mark -  单例
+ (instancetype)sharedInstance {
    // 1.定义一个静态变量来保存你类的实例确保在你的类里面保持全局
    static PhonoAlertTool *_sharedInstance = nil;
    
    // 2.定义一个静态的dispatch_once_t变量来确保这个初始化存在一次
    static dispatch_once_t oncePredicate;
    
    // 3.用GCD来执行block初始化实例
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[PhonoAlertTool alloc] init];
        
    });
    
    return _sharedInstance;
}

+  (void)showInView:(UIViewController *)controller imageBlock:(didSelectedWithImageBlock)block {
    PhonoAlertTool *tool = [PhonoAlertTool sharedInstance];
    [tool showInView:controller imageBlock:block];
}

- (void)showInView:(UIViewController *)controller imageBlock:(didSelectedWithImageBlock)block {
    self.VC = controller;
    self.imageBlock = block;
    
    UIAlertController *actionSheetVC = [UIAlertController alertControllerWithTitle:@"标题" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof (self)weakSelf = self;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openPhotoLibrary];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    //把action添加到actionSheet里
    [actionSheetVC addAction:action1];
    [actionSheetVC addAction:action2];
    [actionSheetVC addAction:action3];
    
    //相当于之前的[actionSheet show];
    [self.VC presentViewController:actionSheetVC animated:YES completion:nil];
}

#pragma mark -- 打开拍照
- (void)takePhoto
{
    if ([self accessCameraAuthorized]) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            [self.VC presentViewController:imagePicker animated:YES completion:nil];
        }
    }
    
}
#pragma mark -- 打开相册
- (void)openPhotoLibrary
{
    if ([self accessPhotoLibraryAuthorized]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        imagePicker.allowsEditing = YES;
        [self.VC presentViewController:imagePicker animated:YES completion:nil];
    }
    
}
#pragma mark -- 访问照相机权限  YES：同意访问 NO:拒绝
- (BOOL)accessCameraAuthorized
{
    if (IOS_VERSION >= 7.0) {
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        //        authStatus = AVAuthorizationStatusNotDetermined;
        if (authStatus == AVAuthorizationStatusRestricted) {
            NSLog(@"Restricted");
            
        } else if (authStatus == AVAuthorizationStatusDenied) {
            //明确拒绝访问拍照
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的照相机已拒绝访问"
                                                            message:@"要启用照相机，请先进入手机的\n \"设置->隐私->相机->广金所\"开启授权"
                                                           delegate:nil
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            return NO;
            
        } else if (authStatus == AVAuthorizationStatusAuthorized) {
            NSLog(@"Authorized");   //已授权
            
        } else if (authStatus == AVAuthorizationStatusNotDetermined) {
            //尚未明确做出选择这个应用的问候
            __block BOOL accessGranted = NO;
            //开启同步，必须等待下方block回调再执行
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                accessGranted = granted;
                dispatch_semaphore_signal(sema);
                
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            return  accessGranted;
        } else {
            NSLog(@"Unknown authorization status");
            return NO;
        }
        
    }
    
    return YES;
}

#pragma mark -  访问相册的权限
- (BOOL)accessPhotoLibraryAuthorized
{
    if (IOS_VERSION >= 7.0) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        //        author = ALAuthorizationStatusNotDetermined;
        switch (author) {
            case ALAuthorizationStatusNotDetermined: {
                //0 用户尚未做出了选择这个应用程序的问候
                
                ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
                __weak __typeof(self)weakSelf = self;
                [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                    if (*stop) {
                        [weakSelf performSelectorOnMainThread:@selector(openPhotoLibrary) withObject:nil waitUntilDone:NO];
                    }
                    *stop = TRUE;
                    
                } failureBlock:^(NSError *error) {
                    
                }];
                return NO;
            }
                break;
                
            case ALAuthorizationStatusRestricted: {
                //1 此应用程序没有被授权访问的照片数据。可能是家长控制权限。
            }
                break;
                
            case ALAuthorizationStatusDenied: {
                //2 明确拒绝访问拍照
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的手机相册已拒绝访问"
                                                                message:@"要访问手机相册，请先进入手机的\n \"设置->隐私->照片->广金所\"开启授权"
                                                               delegate:nil
                                                      cancelButtonTitle:@"知道了"
                                                      otherButtonTitles:nil, nil];
                [alert show];
                return NO;
            }
                break;
                
            case ALAuthorizationStatusAuthorized: {
                //3 用户已授权应用访问照片数据.
            }
                break;
                
            default:
                break;
        }
    }
    
    return YES;
}

#pragma mark -  imagePicke的代理
//将选取到的图片传递给Printscreen
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    ALAssetsLibrary* alLibrary = [[ALAssetsLibrary alloc] init];
    __weak typeof (self)weakSelf = self;
    //    计算原图的大小
    [alLibrary assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset){
        
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        CGFloat bytes = [[NSNumber numberWithLongLong:representation.size] floatValue];
        
        if (weakSelf.imageBlock) {
            weakSelf.imageBlock(image, bytes);
        };
        
    }failureBlock:^(NSError *error){
        
        
    }];
    
  
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
