//
//  ScrollViewController.m
//  MasonryFirDemo
//
//  Created by shavekevin on 16/4/22.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ScrollViewVC.h"
#import "MMPlaceHolder.h"

@interface ScrollViewVC ()

@end

@implementation ScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpUI];
    [self setUpUIButton];
    [self.view setBackgroundColor:[UIColor orangeColor]];
}
//横向的scrollview

- (void)setUpUIButton {
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    UIButton *lastView = nil;
    NSInteger  totalNumber = 10;
    for (NSInteger i = 1; i <= totalNumber; i ++) {
        UIButton *contentViews = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrollView addSubview:contentViews];
        [contentViews addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
        [contentViews showPlaceHolderWithLineColor:[UIColor redColor] backColor: [UIColor colorWithHue:( arc4random() % 255 / 256.0 )
                                                                                            saturation:( arc4random() % 255 / 256.0 )
                                                                                            brightness:( arc4random() % 255 / 256.0 )
                                                                                                 alpha:1] arrowSize:2.0f];
        
        [contentViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(30);
            
            make.width.mas_equalTo(20*i);
            if (lastView) {
                make.left.equalTo(lastView.mas_right).with.offset(10);
                
            } else  {
                make.left.mas_equalTo(10);
            }
            
            if (i == totalNumber) {
                make.right.mas_equalTo(-10);
            }
        }];
        lastView = contentViews;
    }
    
}
- (void)tap {
    NSLog(@"tap");
}
/**
 *  纵向scrollview
 */
- (void)setUpUI {
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(100, 10, 10, 10));
        
    }];
    
    UIView *contentView = ({
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        [scrollView addSubview:view];
        contentView = view;
    });
    [contentView showPlaceHolderWithLineColor:[UIColor redColor] backColor:[UIColor orangeColor] arrowSize:2.0f];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    NSInteger counts = 10;
    UIView *lastView = nil;
    for (NSInteger i = 1; i <= counts ; i ++) {
        UIView *subview = [UIView new];
        [contentView addSubview:subview];
        [subview showPlaceHolderWithLineColor:[UIColor redColor] backColor:[UIColor clearColor] arrowSize:2.0f];
        subview.backgroundColor =  [UIColor colorWithHue:( arc4random() % 255 / 256.0 )
                                              saturation:( arc4random() % 255 / 256.0 )
                                              brightness:( arc4random() % 255 / 256.0 )
                                                   alpha:1];
        [subview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(contentView);
            make.height.mas_equalTo(@(20*i));
            
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                
                make.top.mas_equalTo(contentView.mas_top);
            }
        }];
        
        lastView = subview;
    }
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
    
}


/**
 *  GCC装逼式写法
 */
- (void)setSomething{
    
    UIScrollView *scrollView = ({
        UIScrollView *src = [[UIScrollView alloc]init];
        src.backgroundColor = [UIColor redColor];
        [self.view addSubview:src];
        src;
    });
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
