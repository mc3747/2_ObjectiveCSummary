/*
 *  Copyright (c) 2014-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the BSD-style license found in the
 *  LICENSE file in the root directory of this source tree. An additional grant
 *  of patent rights can be found in the PATENTS file in the same directory.
 *
 */

#import <Foundation/Foundation.h>

@protocol CKComponentDeciding <NSObject>

/*
 * Returns YES if the model is component-eligible
 * No otherwise
 */
+ (BOOL)isModelComponentCompliant:(id)model;

@end
