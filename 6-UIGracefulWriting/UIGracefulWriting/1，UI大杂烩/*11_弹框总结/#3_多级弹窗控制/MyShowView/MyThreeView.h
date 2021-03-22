//
//  MyThreeView.h
//  AlertViewDemo
//
//  Created by LeeMiao on 2019/8/12.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MyThreeViewActionBlock)(UIButton *sender);

@interface MyThreeView : UIView

@property (nonatomic,copy) MyThreeViewActionBlock actionBlock;

@property (nonatomic,strong) NSString *title;

@end

