//
//  UIImagePickerController+RFBlocks.m
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "UIImagePickerController+RFBlocks.h"
#import <objc/runtime.h>

static const char kFinishBlockKey;

@implementation UIImagePickerController (RFBlocks)

+ (UIImagePickerController *)rf_imagePickerWithFinishBlock:(RFImagePickerFinishBlock)finishBlock
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.rf_finishBlock = finishBlock;
    
    return picker;
}

- (RFImagePickerFinishBlock)rf_finishBlock {
    return objc_getAssociatedObject(self, &kFinishBlockKey);
}

- (void)setRf_finishBlock:(RFImagePickerFinishBlock)rf_finishBlock {
    self.delegate = self;
    
    objc_setAssociatedObject(self, &kFinishBlockKey, rf_finishBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    RFImagePickerFinishBlock block = self.rf_finishBlock;
    
    if (block)  block(info);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.rf_finishBlock = nil;
}

@end
