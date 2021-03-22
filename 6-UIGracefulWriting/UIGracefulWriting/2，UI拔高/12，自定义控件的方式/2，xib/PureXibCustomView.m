//
//  CustomView.m
//  自定义控件
//
//  Created by gjfax on 16/6/3.
//  Copyright © 2016年 macheng. All rights reserved.
//

#import "PureXibCustomView.h"
#import "PureXibCustomModel.h"

@interface PureXibCustomView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (nonatomic, assign) CGRect myframe;
@end

@implementation PureXibCustomView

//方法1：使用自定义方法
+ (instancetype)customViewShow {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

//方法2： 使用initWithFrame，要搭配drawRect
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs=[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
        self=[nibs objectAtIndex:0];
        _myframe = frame;
    }
    return self;
}
-(void)drawRect:(CGRect)rect {
    self.frame=_myframe;//关键点在这里
}

//设置模型
- (void)setModel:(PureXibCustomModel *)model {
    // set方法里边，不能用self，即不能写成self.model,而要写成_model
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.imageName];
    self.iconLabel.text = model.labelName;
}
@end
