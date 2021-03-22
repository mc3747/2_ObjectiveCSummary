//
//  SexPickerButton.h
//  SmartMedicalPlatformIM
//
//  Created by gjfax on 2019/3/27.
//  Copyright © 2019 SevenShare. All rights reserved.
//

#import "ZFButton.h"

typedef void(^SexPickerButtonBlock)(NSString * _Nullable pickDate);

NS_ASSUME_NONNULL_BEGIN

@interface SexPickerButton : ZFButton
@property (nonatomic,strong)SexPickerButtonBlock pickBlock;
@property (nonatomic,strong)NSMutableArray *dataSourceArray;
@end

NS_ASSUME_NONNULL_END
