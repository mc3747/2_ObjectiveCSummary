//
//  MacroTestObject.h
//  排序总结
//
//  Created by gjfax on 2020/3/27.
//  Copyright © 2020 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TestBlock)(void) ;
@interface MacroTestObject : NSObject
@property (nonatomic,copy)TestBlock testBlock;
@end

NS_ASSUME_NONNULL_END
