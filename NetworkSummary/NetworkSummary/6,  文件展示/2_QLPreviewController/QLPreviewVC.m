//
//  QLPreviewVC.m
//  NetworkSummary
//
//  Created by gjfax on 2020/3/20.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "QLPreviewVC.h"
#define PDF_FILE_PATH1 [[NSBundle mainBundle] pathForResource:@"001" ofType:@"pdf"]
#define PDF_FILE_PATH2 [[NSBundle mainBundle] pathForResource:@"003" ofType:@"pdf"]

@interface QLPreviewVC()<QLPreviewControllerDelegate,QLPreviewControllerDataSource>

@end

@implementation QLPreviewVC
- (void)viewDidLoad{
    self.delegate = self;
    self.dataSource = self;
}
#pragma mark QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 2;
}
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    NSArray *arr = @[PDF_FILE_PATH1,PDF_FILE_PATH2];
    
    return [NSURL fileURLWithPath:arr[index]];
}


@end
