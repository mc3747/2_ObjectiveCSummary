//
//  NSObject+AssociatedObject.m
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)

static char kAssociatedObjectKey;

// write style 1

- (id)associatedObject1
{
    return objc_getAssociatedObject(self, @selector(associatedObject1));
}

- (void)setAssociatedObject1:(id)associatedObject
{
    objc_setAssociatedObject(self, @selector(associatedObject1), associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// write style 2

- (id)associatedObject2
{
    return objc_getAssociatedObject(self,&kAssociatedObjectKey);
}

- (void)setAssociatedObject2:(id)associatedObject
{
    objc_setAssociatedObject(self, &kAssociatedObjectKey, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// write style 3

- (id)associatedObject3 {
    return objc_getAssociatedObject(self,_cmd);
}

- (void)setAssociatedObject3:(id)associatedObject {
    objc_setAssociatedObject(self, @selector(associatedObject3), associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
