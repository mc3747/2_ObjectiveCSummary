//
//  ViewController.m
//  MNFoundation
//
//  Created by Vincent on 2019/7/10.
//  Copyright © 2019 Vincent. All rights reserved.
//

#import "ViewController.h"
#import "MNCropView.h"

@interface ViewController ()
{
    UIView *_v;
}
@property (nonatomic, strong) MNMenuView *menuView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *v = [UIButton buttonWithFrame:CGRectMake(0.f, 0.f, 100.f, 50.f) image:nil title:@"提取音频" titleColor:UIColor.whiteColor titleFont:UIFontRegular(16.f)];
    v.center_mn = self.contentView.bounds_center;
    v.top_mn = self.contentView.height_mn/3.f;
    UIViewSetCornerRadius(v, v.height_mn/2.f);
    v.backgroundColor = UIColor.blueColor;
    [v addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:v];
    _v = v;
    
//    [self.view showLoadDialog:@"弹框测试"];
//    dispatch_after_main(3.f, ^{
//        [self.view closeDialog];
//    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)buttonClicked:(UIButton *)b {
    [[MNCityPicker new] showInView:self.view selectHandler:^(MNCityPicker *picker) {
        NSLog(@"");
    }];
    return;
    MNAssetPicker *p = MNAssetPicker.new;
    p.configuration.allowsPickingGif = NO;
    p.configuration.allowsPickingPhoto = NO;
    p.configuration.allowsPickingVideo = YES;
    p.configuration.maxPickingCount = 1;
    p.configuration.allowsPreviewing = NO;
    p.configuration.allowsCapturing = YES;
    p.configuration.maxCaptureDuration = 60.f;
    p.configuration.allowsWritToAlbum = YES;
    [p presentWithPickingHandler:^(MNAssetPicker *picker, NSArray<MNAsset *> *assets) {
        //[self exportVideoAtPath:assets.firstObject.content];
        [self.view showLoadDialog:@"正在导出"];
        [MNAssetHelper exportVideoWithAsset:assets.firstObject
                             outputPath:nil
                                 presetName:AVAssetExportPresetHighestQuality
                            progressHandler:^(float progress) {
            
        } completionHandler:^(NSString *filePath) {
            [self.view closeDialog];
        }];
    } cancelHandler:^(MNAssetPicker *picker) {
        [self.view showInfoDialog:@"已取消"];
    }];
}

- (void)exportVideoAtPath:(NSString *)path {
    CGSize s = [MNAssetExporter exportNaturalSizeOfVideoAtPath:path];
    CGSize z = CGSizeMultiplyByRatio(s, .5f);
    CGRect r = CGRectMake(s.width/4.f, s.height/4.f, z.width, z.height);
    NSString *pa = MNCacheDirectoryAppending(MNFileMP4Name);
    MNAssetExportSession *e = MNAssetExportSession.new;
    e.filePath = path;
    e.outputPath = pa;
    e.shouldOptimizeForNetworkUse = NO;
    e.outputRect = r;
    //@weakify(self);
    [self.view showLoadDialog:@"加载中"];
    [e exportAsynchronouslyWithCompletionHandler:^(AVAssetExportSessionStatus status, NSError * _Nullable error) {
        dispatch_async_main(^{
            //@strongify(self);
            if (status == AVAssetExportSessionStatusCompleted) {
                NSString *ss = pa;
                [self.view showCompletedDialog:@"提取成功"];
            } else if (error) {
                [self.view showInfoDialog:error.localizedDescription];
            }
        });
    }];
}

- (MNMenuView *)menuView {
    if (!_menuView) {
        MNMenuView *menuView = [MNMenuView menuWithAlignment:MNMenuAlignmentVertical handler:^(MNMenuView * _Nonnull menuView, UIView * _Nonnull item) {
        } titles:@"复制", @"粘贴", @"粘贴", @"粘贴", nil];
        menuView.configuration.animationType = MNMenuAnimationZoom;
        menuView.configuration.animationDuration = MNMenuArrowDown;
        menuView.configuration.arrowOffset = UIOffsetMake(25.f, 3.f);
        menuView.configuration.contentInsets = UIEdgeInsetsZero;
        menuView.configuration.animationDuration = .27f;
        menuView.targetView = _v;
        _menuView = menuView;
    }
    return _menuView;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view showInfoDialog:@"背景点击"];
}

@end
