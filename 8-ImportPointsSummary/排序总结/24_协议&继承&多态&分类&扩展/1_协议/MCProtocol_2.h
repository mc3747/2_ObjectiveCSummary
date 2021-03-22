//
//  MCProtocol_2.h
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCProtocol_2 <NSObject>
@property (nonatomic,copy) NSString *sportType;
- (void)run;
- (void)swim;
@end

NS_ASSUME_NONNULL_END
