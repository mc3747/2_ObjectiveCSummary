/* @project  __PROJECTNAME__
 *  @header  __FILENAME__
 *  @date  __DATE__
 *  @copyright  __COPYRIGHT__
 *  @author  小斯
 *  @brief  视频录制/拍照
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MNCaptureResizeMode) {
    MNCaptureResizeModeResize = 0,
    MNCaptureResizeModeResizeAspect,
    MNCaptureResizeModeResizeAspectFill
};

typedef NS_ENUM(NSInteger, MNCapturePosition) {
    MNCapturePositionBack = 0,
    MNCapturePositionFront
};

typedef NSString * MNCapturePresetName;
FOUNDATION_EXTERN MNCapturePresetName const MNCapturePresetLowQuality;
FOUNDATION_EXTERN MNCapturePresetName const MNCapturePresetMediumQuality;
FOUNDATION_EXTERN MNCapturePresetName const MNCapturePresetHighQuality;

@class MNCapturer;
@protocol MNCapturerDelegate <NSObject>
@optional
- (void)capturerDidStartCapturing:(MNCapturer *)capturer;
- (void)capturerDidFinishCapturing:(MNCapturer *)capturer;
- (void)capturerDidEndWithError:(MNCapturer *)capturer;
@end

@interface MNCapturer : NSObject
/**视频拉伸方式*/
@property (nonatomic) MNCaptureResizeMode resizeMode;
/**摄像头*/
@property (nonatomic, readonly) MNCapturePosition capturePosition;
/**录制时长时长*/
@property (nonatomic, readonly) Float64 duration;
/**视频帧率, 默认30*/
@property (nonatomic) NSInteger frameRate;
/**文件地址*/
@property (nonatomic, copy) NSString *outputPath;
/**图像输入*/
@property (nonatomic, weak) UIView *outputView;
/**捕获质量*/
@property (nonatomic, copy) MNCapturePresetName presetName;
/**事件回调*/
@property (nonatomic, weak) id<MNCapturerDelegate> delegate;
/**是否在录制*/
@property (nonatomic, readonly, getter=isCapturing) BOOL capturing;
/**是否在获取*/
@property (nonatomic, readonly, getter=isRunning) BOOL running;
/**错误信息*/
@property (nonatomic, readonly, strong) NSError *error;

/**
 实例化视频捕获者
 @param outputPath 视频输出路径
 @return 视频捕获者
 */
- (instancetype)initWithOutputPath:(NSString *)outputPath;

/**即将捕获影像, 配置数据*/
- (void)prepareCapturing;

#pragma mark - Instance
+ (instancetype)capturer;

#pragma mark - 捕获
- (void)startRunning;
- (void)stopRunning;

#pragma mark - 开始/停止/删除
- (void)startCapturing;
- (void)stopCapturing;
- (BOOL)deleteCapturing;

#pragma mark - 手电筒控制
- (BOOL)openLighting;
- (BOOL)closeLighting;

#pragma mark - 转换镜头方向
- (BOOL)convertCapturePosition;
- (BOOL)setDeviceCapturePosition:(MNCapturePosition)capturePosition;

#pragma mark - 对焦
- (BOOL)setFocusPoint:(CGPoint)point;

#pragma mark - 拍照
- (void)captureStillImageAsynchronously:(void(^)(UIImage *image))completion;

@end

