//
//  DCLogView.m
//  DCLogViewDemo
//
//  Created by DarielChen https://github.com/DarielChen/DCLog
//  Copyright © 2016年 DarielChen. All rights reserved.
//

#import "DCLogView.h"

@interface DCLogView()

@property (nonatomic, strong) UITextView *logTextView;
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UIButton *cleanButton;
@property (nonatomic, strong) UIButton *hideButton;
@property (nonatomic, assign) NSInteger segmentIndex;

@end

@implementation DCLogView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    self.logTextView = [[UITextView alloc] init];
    self.logTextView.backgroundColor = [UIColor colorWithRed:39/255.0 green:40/255.0 blue:34/255.0 alpha:1.0];
    self.logTextView.textColor = [UIColor whiteColor];
    self.logTextView.font = [UIFont systemFontOfSize:14.0];
    self.logTextView.editable = NO;
    self.logTextView.layoutManager.allowsNonContiguousLayout = NO;
    [self addSubview:self.logTextView];
    
    NSArray *segmentArray = @[@"Normal",@"Crash"];
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:segmentArray];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(didClickSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segmentControl];
  
 /*清除按钮 */
    self.cleanButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cleanButton.layer.cornerRadius = 5.0f;
    self.cleanButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.cleanButton setTitle:@"Clean" forState:UIControlStateNormal];
    [self.cleanButton addTarget:self action:@selector(cleanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.cleanButton.layer.borderWidth = 1.0f;
    self.cleanButton.layer.borderColor = [UIColor colorWithRed:12/255.0 green:95/255.0 blue:250/255.0 alpha:1.0].CGColor;
    [self addSubview:self.cleanButton];
    
/*隐藏按钮 */
    self.hideButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.hideButton.layer.cornerRadius = 5.0f;
    self.hideButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.hideButton setTitle:@"隐藏日志" forState:UIControlStateNormal];
    [self.hideButton addTarget:self action:@selector(hiddenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.hideButton.layer.borderWidth = 1.0f;
    self.hideButton.layer.borderColor = [UIColor colorWithRed:12/255.0 green:95/255.0 blue:250/255.0 alpha:1.0].CGColor;
    [self addSubview:self.hideButton];
}

- (void)updateLog:(NSString *)logText {
    if (self.logTextView.contentSize.height <= (self.logTextView.contentOffset.y + CGRectGetHeight(self.bounds))) {
        self.logTextView.text = logText;
        [self.logTextView scrollRangeToVisible:NSMakeRange(self.logTextView.text.length, 1)];
    }else {
        self.logTextView.text = logText;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.logTextView.frame = CGRectMake(0, 64.0, self.bounds.size.width, self.bounds.size.height-64.0);
    
    self.segmentControl.frame = CGRectMake(16.0, 0, 100.0, 30.0);
    self.segmentControl.center= CGPointMake(self.segmentControl.center.x, 42.0);
    
    self.cleanButton.frame = CGRectMake(self.bounds.size.width-16-50, 0, 50.0, 30.0);
    self.cleanButton.center = CGPointMake(self.cleanButton.center.x, 42.0);
    
    self.hideButton.frame = CGRectMake(self.bounds.size.width-16-50 -120, 0, 100.0, 30.0);
    self.hideButton.center = CGPointMake(self.hideButton.center.x, 42.0);
}

- (void)cleanButtonClick {
    
    if (_CleanButtonIndexBlock) {
        _CleanButtonIndexBlock(self.segmentIndex);
    }
}
- (void)hiddenButtonClick {
    
    if (_HiddenButtonIndexBlock) {
        _HiddenButtonIndexBlock(self.segmentIndex);
    }
}
- (void)didClickSegmentedControlAction:(UISegmentedControl *)control {
    if (_indexBlock) {
        _indexBlock(control.selectedSegmentIndex);
    }
    self.segmentIndex = control.selectedSegmentIndex;
}



@end
