//
//  UIDocumentInteractionVC.m
//  NetworkSummary
//
//  Created by gjfax on 2020/3/20.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "UIDocumentInteractionVC.h"

@interface UIDocumentInteractionVC ()<UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong) UIDocumentInteractionController * documentVC;
@end

@implementation UIDocumentInteractionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"002" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.documentVC = [UIDocumentInteractionController interactionControllerWithURL:url];
    self.documentVC.delegate = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL b = [self.documentVC presentPreviewAnimated:YES];
    });
}
 
#pragma mark 代理方法
//为快速预览指定控制器
- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self;
}
 
//为快速预览指定View
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return self.view;
}
 
//为快速预览指定显示范围
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    //    return self.view.frame;
    return CGRectMake(0, 0, self.view.frame.size.width, 300);
}
 
@end


