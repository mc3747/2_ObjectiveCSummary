//
//  MCProtocol.h
//  排序总结
//
//  Created by gjfax on 2020/3/9.
//  Copyright © 2020 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCProtocol_1 <NSObject>
@property (nonatomic,copy) NSString *sportType;
- (void)playFootball;
- (void)playBasketball;

@end

NS_ASSUME_NONNULL_END
