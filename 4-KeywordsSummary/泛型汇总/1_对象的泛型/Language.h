//
//  Language.h
//  泛型汇总
//
//  Created by gjfax on 2018/6/5.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject
@end

@interface IOS : Language
@property (nonatomic, assign) NSInteger number;
@end

@interface JAVA : Language
@property (nonatomic, copy) NSString *number;
@end
