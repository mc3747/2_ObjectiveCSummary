//
//  DifferentTypeFilesVC.m
//  排序总结
//
//  Created by gjfax on 2020/2/7.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "DifferentTypeFilesVC.h"
#import "ShowPDFViewController.h"
#import "ReaderDocument.h"
#import "ReaderViewController.h"

@interface DifferentTypeFilesVC ()<ReaderViewControllerDelegate>

@end

@implementation DifferentTypeFilesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//1_wkwebview
- (IBAction)demo1:(id)sender {
}

//2_QLPreviewController
- (IBAction)demo2:(id)sender {
    GJSPushViewControllerWithName(@"QLPreviewVC", ((UIButton *)sender).titleLabel.text, YES);
}

//3_UIDocumentInteractionController
- (IBAction)demo3:(id)sender {
    GJSPushViewControllerWithName(@"UIDocumentInteractionVC", ((UIButton *)sender).titleLabel.text, YES);
}

//4_CGContext画pdf文档
- (IBAction)demo4:(id)sender {
    GJSPushViewControllerWithName(@"CGContextDrawPDFListViewController", ((UIButton *)sender).titleLabel.text, YES);
    
}

//5_第三方: PDFJS
- (IBAction)demo5:(id)sender {
        ShowPDFViewController *vc = [[ShowPDFViewController alloc] init];
    //    vc.urlStr = @"http://oshsanwqi.bkt.clouddn.com/TestPDF.pdf";
    //    vc.urlStr =@"https://app.gjfax.com/APP_SERVER/remote/trading/getLegalAgreement?gqdm=161248&applicationId=110929";
        
        vc.urlStr = @"https://app.gjfax.com/APP_SERVER/remote/product/getProductSpecification?gqdm=161248";
        
        [self.navigationController pushViewController:vc animated:YES];
}

//6_第三方: vfr/Reader
- (IBAction)demo6:(id)sender {
    //Reader初始化 加载本地pdf文件
            ReaderDocument *doc = [[ReaderDocument alloc] initWithFilePath:[[NSBundle mainBundle] pathForResource:@"001" ofType:@"pdf"] password:nil];
            ReaderViewController *rederVC = [[ReaderViewController alloc] initWithReaderDocument:doc];
            rederVC.delegate = self;
            rederVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            rederVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:rederVC animated:YES completion:nil];
}

#pragma mark ReaderViewControllerDelegate因为PDF阅读器可能是push出来的，也可能是present出来的，为了更好的效果，这个代理方法可以实现很好的退出
- (void)dismissReaderViewController:(ReaderViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
