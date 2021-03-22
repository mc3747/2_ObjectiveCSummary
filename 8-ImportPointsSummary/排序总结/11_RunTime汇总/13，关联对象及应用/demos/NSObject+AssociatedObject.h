//
//  NSObject+AssociatedObject.h
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)

// 3 methods to set assocaited object
@property (nonatomic, strong) id associatedObject1;
@property (nonatomic, strong) id associatedObject2;
@property (nonatomic, strong) id associatedObject3;

@end
