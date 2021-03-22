//
//  KeywordDecorateView.m
//  泛型汇总
//
//  Created by gjfax on 2019/2/21.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "KeywordDecorateView.h"
@interface KeywordDecorateView ()
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@end

@implementation KeywordDecorateView

- (instancetype)init {
    
    return [self initWithFrame:CGRectZero title:@"A" subTitle:@"B"];
}

- (instancetype)initWithFrame:(CGRect )frame {
    
    return [self initWithFrame:frame title:@"A" subTitle:@"B"];
}

- (instancetype)initWithFrame:(CGRect )frame title:(NSString *)title {
    return [self initWithFrame:frame title:title subTitle:@"B"];
}

- (instancetype)initWithFrame:(CGRect )frame subTitle:(NSString *)subTitle {
    return [self initWithFrame:frame title:@"A" subTitle:subTitle];
}

- (instancetype)initWithFrame:(CGRect )frame title:(NSString *)title subTitle:(NSString *)subTitle {
    
    if (self = [super initWithFrame:frame]) {
        _title = title;
        _subTitle = subTitle;
    }
    return self;
}

#pragma mark -  父类的NS_DESIGNATED_INITIALIZER方法initWithCoder
/*
 1，如果要实现，如下；
 2，如果不要实现，可以在声明的时候，在结尾用NS_UNAVAILABLE修饰
 */

//开始解析一个文件时调用：xib或者文档文件
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        
    } ;
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
}

//当从xib当中加载完毕时调用
- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
