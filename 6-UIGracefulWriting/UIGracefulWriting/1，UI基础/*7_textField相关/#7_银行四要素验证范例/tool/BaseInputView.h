//
//  BaseInputView.h
//  UIGracefulWriting
//
//  Created by gjfax on 2019/9/17.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCLabel.h"


NS_ASSUME_NONNULL_BEGIN

@interface BaseInputView : UIView
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIView *triangleView;
@property (nonatomic, weak) MCLabel *errorTipsLabel;

- (void)showTips:(NSString *)tips;
- (void)removeTips;
@end

NS_ASSUME_NONNULL_END
