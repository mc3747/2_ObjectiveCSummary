//
//  SystemSoundModel.h
//  系统声音
//
//  Created by 思久科技 on 16/9/20.
//  Copyright © 2016年 思久科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemSoundModel : NSObject

@property (nonatomic, copy) NSNumber *SoundID;      // 声音ID
@property (nonatomic, copy) NSString *FileName;     // 文件名称
@property (nonatomic, copy) NSString *Category;     // 种类

@end
