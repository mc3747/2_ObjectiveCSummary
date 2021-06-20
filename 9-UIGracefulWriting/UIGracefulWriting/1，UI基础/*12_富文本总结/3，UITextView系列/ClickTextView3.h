//
//  ClickTextView3.h
//  UIGracefulWriting
//
//  Created by gjfax on 2020/1/22.
//  Copyright © 2020 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickStringBlock)(NSInteger index,NSString * _Nullable highlightString);
NS_ASSUME_NONNULL_BEGIN

@interface ClickTextView3 : UITextView
@property (nonatomic, copy) ClickStringBlock clickStringBlock;
- (instancetype)initWithFrame:(CGRect)frame
                contentStirng:(NSString *)contentStirng
             contentAttribute:(NSDictionary<NSAttributedStringKey, id> *)contentAttribute
         highlightStringArray:(NSArray<NSString *> *)highlightStringArray
           hithlightAttribute:(NSArray<NSDictionary<NSAttributedStringKey, id> *> *)highlightAttributeArray
        highlightBgColorArray:(NSArray<UIColor *> *)highlightBgColorArray;
@end

NS_ASSUME_NONNULL_END
