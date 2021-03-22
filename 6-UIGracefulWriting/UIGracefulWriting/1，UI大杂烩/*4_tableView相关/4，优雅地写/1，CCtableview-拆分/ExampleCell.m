//
//  ExampleCell.m
//  CCTableDataSourceDemo
//
//  Created by eHome on 17/2/17.
//  Copyright © 2017年 brefChan. All rights reserved.
//

#import "ExampleCell.h"
#import "UIImageView+WebCache.h"

@implementation ExampleCellItem

@end

@interface ExampleCell()

@property (strong, nonatomic)  UIImageView *exampleCellImageView;
@property (strong, nonatomic)  UILabel *exampleTitleLabel;
@property (strong, nonatomic)  UIButton *exampleButton;


@end

@implementation ExampleCell
@synthesize delegate = _delegate;

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _exampleCellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _exampleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 30)];
        _exampleButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 30, 200, 30)];
        [_exampleButton addTarget:self action:@selector(exampleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_exampleCellImageView];
        [self addSubview:_exampleTitleLabel];
        [self addSubview:_exampleButton];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+ (CGFloat)cellHeightForData:(id)data
{
    return 60;
}

- (void)bindData:(ExampleCellItem *)data
{
    self.exampleTitleLabel.text = data.titleString;
    [self.exampleButton setTitle:data.buttonString forState:UIControlStateNormal];
}

- (void)cellWillDisplayByData:(ExampleCellItem *)data
{
    //当cell在屏幕中显示时才加载图片
    [self.exampleCellImageView sd_setImageWithURL:[NSURL URLWithString:data.imageUrl]];
}

- (void)cellDidEndDisplayByData:(id)data
{
    //如果cell在屏幕中消失时图片还未下载完成,则取消下载
//    [self.exampleCellImageView sd_cancelCurrentAnimationImagesLoad];
    
}

- (void)exampleButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(exampleCell:buttonClick:)])
        [self.delegate exampleCell:self buttonClick:sender];
}


#pragma mark - Getter && Setter
- (id<ExampleCellDelegate>)delegate
{
    return _delegate;
}

- (void)setDelegate:(id<ExampleCellDelegate>)delegate
{
    _delegate = delegate;
}



@end
