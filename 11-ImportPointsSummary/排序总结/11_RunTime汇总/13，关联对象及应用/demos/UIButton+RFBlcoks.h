//
//  UIButton+RFBlcoks.h
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (RFBlcoks)

typedef void(^RFButtonClickBlock)(UIButton *button);

@property (nonatomic, copy) RFButtonClickBlock rf_buttonClickBlock;

@end
