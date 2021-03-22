//
//  PackageEventTableViewCell.h
//  排序总结
//
//  Created by gjfax on 2019/5/10.
//  Copyright © 2019 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PackageEventTableViewCell : UITableViewCell
- (void)addBaseTarget:(id)target action:(SEL)action withObject:(id)object;
@end

NS_ASSUME_NONNULL_END
