//
//  UIImagePickerController+RFBlocks.h
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (RFBlocks)<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

typedef void(^RFImagePickerFinishBlock)(NSDictionary *info);

@property (nonatomic, copy) RFImagePickerFinishBlock rf_finishBlock;

+ (UIImagePickerController *)rf_imagePickerWithFinishBlock:(RFImagePickerFinishBlock)finishBlock;

@end
