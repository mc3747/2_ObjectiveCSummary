//
//  SingleDatasourceManager.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/5/20.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SingleDatasourceManager.h"

@implementation SingleDatasourceManager

+ (id)sharedDataManager
{
    @synchronized(self)
    {
        static NSObject *object = nil;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            object = [[NSObject alloc] init];
        });
        return object;
    }
}
@end
