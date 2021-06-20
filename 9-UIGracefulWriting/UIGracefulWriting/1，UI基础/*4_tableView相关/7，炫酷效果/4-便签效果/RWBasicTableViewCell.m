//
//  RWBasicTableViewCell.m
//  UDo
//
//  Created by Soheil M. Azarpour on 8/9/14.
//  Copyright (c) 2014 Soheil Azarpour. All rights reserved.
//

#import "RWBasicTableViewCell.h"

@implementation RWBasicTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addLabel];
        

    }
    return self;
}

- (void)addLabel {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.width - 20, self.height)];
    self.titleLabel.textColor = [self RandomColor];
    [self addSubview:self.titleLabel];
}



#pragma mark -  随机色
- (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}
@end
