//
//  KVC_Person.h
//  排序总结
//
//  Created by gjfax on 2020/1/16.
//  Copyright © 2020 macheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVC_Book.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVC_Person : NSObject
{
    @private
    int _heightInt;
}

@property (nonatomic, strong,readonly, getter=is) NSString *school;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, assign) int       age;
@property (nonatomic, strong) KVC_Book      *book;
@property (nonatomic, strong) NSArray<KVC_Book *> *books;

@end

NS_ASSUME_NONNULL_END
