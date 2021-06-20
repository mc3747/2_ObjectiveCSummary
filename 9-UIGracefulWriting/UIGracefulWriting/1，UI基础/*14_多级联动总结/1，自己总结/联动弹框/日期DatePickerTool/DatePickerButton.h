//
//  DatePickerButton.h
//  SmartMedicalPlatformIM
//
//  Created by gjfax on 2019/3/27.
//  Copyright © 2019 SevenShare. All rights reserved.
//

#import "ZFButton.h"
typedef void(^DataPickerButtonBlock)(NSString * _Nullable pickDate);

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerButton : ZFButton
@property (nonatomic,strong)DataPickerButtonBlock pickBlock;
@end

NS_ASSUME_NONNULL_END
