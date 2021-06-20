//
//  KVO_Person.m
//  排序总结
//
//  Created by gjfax on 2020/2/6.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "KVO_Person.h"

@implementation KVO_Person
- (void)setName:(NSString *)name
{
    _name = [name copy];
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)willChangeValueForKey:(NSString *)key
{
    [super willChangeValueForKey:key];
    NSLog(@"%s", __FUNCTION__);

}

- (void)didChangeValueForKey:(NSString *)key
{
    [super didChangeValueForKey:key];
    NSLog(@"%s", __FUNCTION__);
}
@end
