//
//  NetWorkingViewController.m
//  GCDDemo
//
//  Created by LeeMiao on 2019/5/5.
//  Copyright © 2019 LiMiao. All rights reserved.
//

#import "NetWorkingViewController.h"

@interface NetWorkingViewController ()

@property (nonatomic,strong) NSArray *picsArr;
@property (nonatomic,strong) UIImageView *imgV1;
@property (nonatomic,strong) UIImageView *imgV2;
@property (nonatomic,strong) UIImageView *imgV3;

@end

@implementation NetWorkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picsArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557058607482&di=e1658859cebd03ae2a017d1cf42965f7&imgtype=0&src=http%3A%2F%2Fimg.zhiribao.com%2Fupload%2Fimages%2F201607%2F6%2F6b0152a5b29f309f3f92f52adc6cd017eae73133.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557058607482&di=a1ea9132e7354e67b3c62eaacce4cacb&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F20182%2F21%2F2018221142159_MZ33z.jpeg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557058607481&di=e5d2886ce2501a2ec7d66d01455e14c3&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201305%2F25%2F20130525153450_nHVaH.thumb.700_0.jpeg"];
    [self configUI];
}

- (void)configUI{
    
    CGFloat imgWidth = self.view.bounds.size.width * 0.3333333;
    
    self.imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, imgWidth, 100)];
    self.imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(imgWidth, 80, imgWidth, 100)];
    self.imgV3 = [[UIImageView alloc] initWithFrame:CGRectMake(imgWidth * 2, 80, imgWidth, 100)];

    [self.view addSubview:self.imgV1];
    [self.view addSubview:self.imgV2];
    [self.view addSubview:self.imgV3];
    
    CGFloat btnWidth = self.view.bounds.size.width;
    UIButton *netWorkingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    netWorkingBtn.frame  = CGRectMake(0, 200, btnWidth, 60);
    [netWorkingBtn addTarget:self action:@selector(netWorkingBegin:) forControlEvents:UIControlEventTouchUpInside];
    [netWorkingBtn setTitle:@"开始下载" forState:UIControlStateNormal];
    [netWorkingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:netWorkingBtn];

}


- (void)netWorkingBegin:(UIButton *)sender{
    
//    [self groupNetWorkingWithSender:sender];
    
    [self semaphoreNetWorkingWithSender:sender];
}


- (void)semaphoreNetWorkingWithSender:(UIButton *)sender{
    
    [sender setTitle:@"正在下载" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.imgV1.image = nil;
    self.imgV2.image = nil;
    self.imgV3.image = nil;
    
    NSArray <UIImageView *> *imgVs = @[self.imgV1,self.imgV2,self.imgV3];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    for ( int i = 0; i < self.picsArr.count; i++) {
        NSLog(@"第%d张开始下载",i);
        [self netWorkingDownloadPicWithUrlStr:self.picsArr[i] completionHandler:^(UIImage *img) {
            NSLog(@"第%d张下载完成",i);
            dispatch_async(dispatch_get_main_queue(), ^{
                imgVs[i].image = img;
            });
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
    
    NSLog(@"所有的图片下载完成");
    [sender setTitle:@"下载完成" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}


/**
 采用GCD 并发组

 @param sender <#sender description#>
 */
- (void)groupNetWorkingWithSender:(UIButton *)sender{
    [sender setTitle:@"正在下载" forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.imgV1.image = nil;
    self.imgV2.image = nil;
    self.imgV3.image = nil;
    
    NSArray <UIImageView *> *imgVs = @[self.imgV1,self.imgV2,self.imgV3];
    
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for ( int i = 0; i < self.picsArr.count; i++) {
        NSLog(@"第%d张开始下载",i);
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            [self netWorkingDownloadPicWithUrlStr:self.picsArr[i] completionHandler:^(UIImage *img) {
                NSLog(@"第%d张下载完成",i);
                dispatch_group_leave(group);
                dispatch_async(dispatch_get_main_queue(), ^{
                    imgVs[i].image = img;
                });
                
            }];
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有的图片下载完成");
        [sender setTitle:@"下载完成" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    });
    
}



/**
 网络请求下载网络上的图片

 @param urlStr 图片地址
 @param completionHandler 下载完成后的回掉
 */
- (void)netWorkingDownloadPicWithUrlStr:(NSString *)urlStr completionHandler:(void(^)(UIImage *img))completionHandler {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error && data) {
            
            UIImage *image = [UIImage imageWithData:data];
            !completionHandler ? :completionHandler(image);
            
        }else{
            
            !completionHandler ? :completionHandler(nil);
            
        }
        
    }];
    [dataTask resume];
    
}


@end
