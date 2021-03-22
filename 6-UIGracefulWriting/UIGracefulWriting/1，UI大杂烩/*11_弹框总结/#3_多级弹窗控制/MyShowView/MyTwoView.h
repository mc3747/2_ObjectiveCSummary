//
//  MyTwoView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyTwoViewActionBlock)(UIButton *sender);

@interface MyTwoView : UIView

@property (nonatomic,copy) MyTwoViewActionBlock actionBlock;

@property (nonatomic,strong) NSString *title;

@end
