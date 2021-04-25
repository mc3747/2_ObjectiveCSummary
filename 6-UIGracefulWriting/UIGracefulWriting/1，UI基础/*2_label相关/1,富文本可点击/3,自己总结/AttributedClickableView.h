//
//  AttributedClickableView.h
//  UIGracefulWriting
//
//  Created by gjfax on 2020/1/20.
//  Copyright © 2020 macheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickImageBlock)(bool );
typedef void(^ClickStringBlock)(NSString *);
@interface AttributedClickableView : UIView
@property (nonatomic, copy) NSString *normalString;

@property (nonatomic, copy) ClickImageBlock clickImageBlock;
@property (nonatomic, copy) ClickStringBlock clickStringBlock;

-(instancetype)initWithFrame:(CGRect)frame
                 normalImage:(UIImage *)normalImage
              highlightImage:(UIImage *)highlightImage
                normalString:(NSString *)normalString
                highlightStringArray:(NSArray <NSString *>*)highlightStringArray
            imageBlock:(ClickImageBlock)imageBlock
                 stringBlock:(ClickStringBlock)clickStringBlock;
    
@end

NS_ASSUME_NONNULL_END
