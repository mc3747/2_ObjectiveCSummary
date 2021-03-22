//
//  FKTextView.m
//  FloatableKeyboard
//
//  Created by anjohnlv on 2017/9/4.
//  Copyright © 2017年 anjohnlv. All rights reserved.
//

#import "FKTextView.h"
#import "UIView+FloatKeyboard.h"

@implementation FKTextView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.floatable = YES;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.floatable = YES;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.floatable = YES;
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    self.floatable = YES;
}

@end
