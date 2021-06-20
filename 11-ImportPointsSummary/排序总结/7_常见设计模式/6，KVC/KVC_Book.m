//
//  KVC_Book.m
//  排序总结
//
//  Created by gjfax on 2020/1/16.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "KVC_Book.h"

@implementation KVC_Book
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@,%p>{bookname:%@}", [self class],self,self.bookName];
}



@end
