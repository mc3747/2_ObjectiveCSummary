//
//  MyOneView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyOneViewActionBlock)(UIButton *sender);

@interface MyOneView : UIView

@property (nonatomic,copy) MyOneViewActionBlock actionBlock;

@property (nonatomic,strong) NSString *title;

@end

