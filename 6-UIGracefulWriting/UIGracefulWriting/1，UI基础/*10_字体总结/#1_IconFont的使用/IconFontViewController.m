//
//  ViewController.m
//  IconfontDemo001
//
//  Created by zhangyan on 2018/5/21.
//  Copyright © 2018年 zhangyan. All rights reserved.
//

#import "IconFontViewController.h"
#import "UIImage+IconFont.h"

@interface IconFontViewController ()

@end

@implementation IconFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 /*1，label的text */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 300, 50)];
    // 字体使用下面对比出来的字体
    label.font = [UIFont fontWithName:@"iconfont" size:35];
    // 采用Unicode码进行
    label.text = @"1，label的text： \U0000e603 \U0000e604  \U0000e605  \U0000e606  \U0000e607";
    label.textColor = [UIColor orangeColor];
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
    
 /*2，imageView的image */
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 250, 100, 100)];
    imageView1.image = [UIImage imageWithIconFontName:@"iconfont" fontSize:80 text:@"\U0000e632" color:[UIColor greenColor]];
    imageView1.layer.borderColor = [UIColor redColor].CGColor;
    imageView1.layer.borderWidth = 1;
    imageView1.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageView1];
 
/*3，button的title */
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetMaxY(imageView1.frame)+20, 100, 50);
    [btn setTitle:@"夹子" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:btn];
    
    UIImage *normalImage = [UIImage imageWithIconFontName:@"iconfont" fontSize:40 text:@"\U0000e636" color:[UIColor cyanColor]];
    [btn setImage:normalImage forState:UIControlStateNormal];
    
    
//    [self checkAll];
    
}
- (void)checkAll
{
    
    NSArray*familyNames = [UIFont familyNames];
    
    NSLog(@"familyNames.count === %ld",familyNames.count);
    
    for(NSString*familyName in familyNames ){
        
        printf("Family: %s \n", [familyName UTF8String]);
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end


