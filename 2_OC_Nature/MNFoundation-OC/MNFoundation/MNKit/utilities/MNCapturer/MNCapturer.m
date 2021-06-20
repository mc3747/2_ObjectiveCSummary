/* @project  __PROJECTNAME__
 *  @header  __FILENAME__
 *  @date  __DATE__
 *  @copyright  __COPYRIGHT__
 *  @author  小斯
 *  @brief  视频录制
 */

#import "MNCapturer.h"
#import "MNAuthenticator.h"
#import "MNFileManager.h"
#import "UIAlertView+MNHelper.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

MNCapturePresetName const MNCapturePresetLowQuality = @"com.mn.capture.low";
MNCapturePresetName const MNCapturePresetMediumQuality = @"com.mn.capture.medium";
MNCapturePresetName const MNCapturePresetHighQuality = @"com.mn.capture.high";

static BOOL MNCaptureIsEmptySize (CGSize size) {
    return (isnan(size.width) || isnan(size.height) || size.width <= 0.f || size.height <= 0.f);
}

@interface MNCapturer ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>
@property (nonatomic) dispatch_queue_t writeQueue;
@property (nonatomic) dispatch_queue_t outputQueue;
@property (nonatomic) MNCapturePosition capturePosition;
@property (nonatomic, getter=isWriting) BOOL writing;
@property (nonatomic, getter=isLocking) BOOL locking;
@property (nonatomic, getter=isCapturing) BOOL capturing;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *audioSettings;
@property (nonatomic, strong) NSDictionary *videoSettings;
@property (nonatomic, strong) AVAssetWriter *writer;
@property (nonatomic, strong) AVAssetWriterInput *videoInputWriter;
@property (nonatomic, strong) AVAssetWriterInput *audioInputWriter;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureDeviceInput *audioInput;
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, strong) AVCaptureAudioDataOutput *audioOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoLayer;
@end

@implementation MNCapturer
+ (MNCapturer *)capturer {
    return MNCapturer.new;
}
- (instancetype)init {
    if (self = [super init]) {
        [self initialized];
    }
    return self;
}

- (instancetype)initWithOutputPath:(NSString *)outputPath {
    if (self = [self init]) {
        self.outputPath = outputPath;
    }
    return self;
}

- (void)initialized {
    _writing = NO;
    _locking = NO;
    _capturing = NO;
    _frameRate = 25;
    _resizeMode = MNCaptureResizeModeResizeAspect;
    _capturePosition = MNCapturePositionBack;
    _writeQueue = dispatch_queue_create("com.mn.capture.write.queue", DISPATCH_QUEUE_SERIAL);
    _outputQueue = dispatch_queue_create("com.mn.capture.output.queue", DISPATCH_QUEUE_SERIAL);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didEnterBackgroundNotification)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willEnterForegroundNotification)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)prepareCapturing {
    [MNAuthenticator requestCameraAuthorizationStatusWithHandler:^(BOOL allowed) {
        if (!allowed) {
            [self captureFailureWithCode:AVErrorApplicationIsNotAuthorized description:@"请开启摄像头权限后重试!"];
            return;
        }
        [MNAuthenticator requestMicrophoneAuthorizationStatusWithHandler:^(BOOL allow) {
            if (!allow) {
                [self captureFailureWithCode:AVErrorApplicationIsNotAuthorized description:@"请开启麦克风权限后重试!"];
                return;
            }
            if (![self sessionCategoryActive:YES]) {
                [self captureFailureWithDescription:@"录像设备初始化失败!"];
                return;
            }
            dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
                [self setupVideo];
                [self setupAudio];
                [self setupStillImage];
                [self setOutputView:_outputView];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.session startRunning];
                });
            });
        }];
    }];
}

- (BOOL)sessionCategoryActive:(BOOL)active {
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:&error];
    if (!error) return [[AVAudioSession sharedInstance] setActive:active error:&error];
    return NO;
}

#pragma mark - 设置视频/音频
- (void)setupVideo {
    NSError *error = nil;
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self captureDeviceWithPosition:self.capturePosition] error:&error];
    if (error) {
        [self captureFailureWithDescription:@"录像设备初始化失败!"];
        return;
    }
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    } else {
        [self captureFailureWithDescription:@"录像设备初始化失败!"];
        return;
    }
    self.videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    self.videoOutput.alwaysDiscardsLateVideoFrames = YES;
    [self.videoOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange]}];
    [self.videoOutput setSampleBufferDelegate:self queue:self.outputQueue];
    if ([self.session canAddOutput:self.videoOutput]) {
        [self.session addOutput:self.videoOutput];
    } else {
        [self captureFailureWithDescription:@"录像设备初始化失败!"];
    }
}

- (void)setupAudio {
    NSError *error = nil;
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:&error];
    if (error) {
        [self captureFailureWithDescription:@"录音设备初始化失败!"];
        return;
    }
    if ([self.session canAddInput:self.audioInput]) {
        [self.session addInput:self.audioInput];
    } else {
        [self captureFailureWithDescription:@"录音设备初始化失败!"];
        return;
    }
    self.audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    [self.audioOutput setSampleBufferDelegate:self queue:self.outputQueue];
    if ([self.session canAddOutput:self.audioOutput]) {
        [self.session addOutput:self.audioOutput];
    } else {
        [self captureFailureWithDescription:@"录音设备初始化失败!"];
    }
}

- (void)setupStillImage {
    AVCaptureStillImageOutput *imageOutput = [[AVCaptureStillImageOutput alloc] init];
    [imageOutput setOutputSettings:@{AVVideoCodecKey:AVVideoCodecJPEG}];
    if ([self.session canAddOutput:imageOutput]) {
        [self.session addOutput:imageOutput];
        self.imageOutput = imageOutput;
    }
}

#pragma mark - 开始/停止捕获
- (void)startRunning {
    if (!_session.isRunning) [_session startRunning];
}

- (void)stopRunning {
    if (_session.isRunning) [_session stopRunning];
}

#pragma mark - 开始/停止录像
- (void)startCapturing {
    if (self.isCapturing) return;
    if (_outputPath.length <= 0 || !_session.isRunning) {
        [self captureFailureWithDescription:@"相机设置错误"];
        return;
    }
    __weak typeof(self)weakself = self;
    [self startWritingWithCompletionHandler:^{
        if (weakself.error) {
            [self captureFailureWithError:weakself.error];
        } else {
            weakself.capturing = YES;
            if ([weakself.delegate respondsToSelector:@selector(capturerDidStartCapturing:)]) {
                [weakself.delegate capturerDidStartCapturing:weakself];
            }
        }
    }];
}

- (void)startWritingWithCompletionHandler:(void (^)(void))completionHandler {
    NSError *error;
    AVAssetWriter *writer = [AVAssetWriter assetWriterWithURL:[NSURL fileURLWithPath:_outputPath] fileType:AVFileTypeMPEG4 error:&error];
    if (error) {
        self.error = error;
        if (completionHandler) completionHandler();
        return;
    }
    AVAssetWriterInput *videoInputWriter = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:self.videoSettings];
    /// 必须设为YES, 需要从 session 实时获取数据
    videoInputWriter.expectsMediaDataInRealTime = YES;
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeRight) {
        videoInputWriter.transform = CGAffineTransformMakeRotation(M_PI);
    } else if (orientation == UIDeviceOrientationLandscapeLeft) {
        videoInputWriter.transform = CGAffineTransformMakeRotation(0.f);
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        videoInputWriter.transform = CGAffineTransformMakeRotation(M_PI+M_PI_2);
    } else {
        videoInputWriter.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    if ([writer canAddInput:videoInputWriter]) {
        [writer addInput:videoInputWriter];
    } else {
        self.error = [NSError errorWithDomain:AVFoundationErrorDomain
                                         code:AVErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey:@"can not add video writer"}];
        if (completionHandler) completionHandler();
        return;
    }
    /// 音频
    AVAssetWriterInput *audioInputWriter = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:self.audioSettings];
    audioInputWriter.expectsMediaDataInRealTime = YES;
    if ([writer canAddInput:audioInputWriter]) {
        [writer addInput:audioInputWriter];
    } else {
        self.error = [NSError errorWithDomain:AVFoundationErrorDomain
                                         code:AVErrorExportFailed
                                     userInfo:@{NSLocalizedDescriptionKey:@"can not add audio writer"}];
        if (completionHandler) completionHandler();
        return;
    }
    self.error = nil;
    self.writing = NO;
    self.writer = writer;
    self.videoInputWriter = videoInputWriter;
    self.audioInputWriter = audioInputWriter;
    if (completionHandler) completionHandler();
}

- (void)stopCapturing {
    if (!self.isCapturing) return;
    self.capturing = NO;
    __weak typeof(self)weakself = self;
    [self.writer finishWritingWithCompletionHandler:^{
        weakself.writing = NO;
        if (!weakself.error) weakself.error = weakself.writer.error;
        weakself.writer = nil;
        weakself.videoInputWriter = nil;
        weakself.audioInputWriter = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([weakself.delegate respondsToSelector:@selector(capturerDidFinishCapturing:)]) {
                [self.delegate capturerDidFinishCapturing:weakself];
            }
        });
    }];
}

- (BOOL)deleteCapturing {
    if (self.isCapturing) return NO;
    self.writing = NO;
    return [NSFileManager.defaultManager removeItemAtPath:_outputPath error:nil];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate AVCaptureAudioDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    /// 调整摄像头, 停止录制时不写入
    if (sampleBuffer == NULL || !self.isCapturing || self.isLocking) return;
    if (connection == [self.videoOutput connectionWithMediaType:AVMediaTypeVideo]) {
        @synchronized (self) {
            [self appendSampleBuffer:sampleBuffer ofMediaType:AVMediaTypeVideo];
        }
    } else if (connection == [self.audioOutput connectionWithMediaType:AVMediaTypeAudio]) {
        @synchronized (self) {
            [self appendSampleBuffer:sampleBuffer ofMediaType:AVMediaTypeAudio];
        }
    }
}

- (void)appendSampleBuffer:(CMSampleBufferRef)sampleBuffer ofMediaType:(AVMediaType)mediaType {
    @autoreleasepool {
        if (!self.isWriting && mediaType == AVMediaTypeVideo) {
            if (mediaType != AVMediaTypeVideo || ![self.writer startWriting]) return;
            [self.writer startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
            self.writing = YES;
        }
        if (mediaType == AVMediaTypeVideo && self.videoInputWriter.readyForMoreMediaData) {
            if (![self.videoInputWriter appendSampleBuffer:sampleBuffer]) {
                [self stopCapturing];
            }
        } else if (mediaType == AVMediaTypeAudio && self.audioInputWriter.readyForMoreMediaData) {
            if (![self.audioInputWriter appendSampleBuffer:sampleBuffer]) {
                [self stopCapturing];
            }
        }
    }
}

#pragma mark - 手电筒控制
- (BOOL)openLighting {
    __block BOOL succeed = NO;
    [self changeDeviceConfigurationHandler:^(AVCaptureDevice *device) {
        if ([device hasTorch] && [device isTorchModeSupported:AVCaptureTorchModeOn]) {
            if (device.torchMode != AVCaptureTorchModeOn) {
                [device setTorchMode:AVCaptureTorchModeOn];
            }
            succeed = YES;
        }
    }];
    return succeed;
}

- (BOOL)closeLighting {
    __block BOOL succeed = NO;
    [self changeDeviceConfigurationHandler:^(AVCaptureDevice *device) {
        if ([device hasTorch] && [device isTorchModeSupported:AVCaptureTorchModeOff]) {
            if (device.torchMode != AVCaptureTorchModeOff) {
                [device setTorchMode:AVCaptureTorchModeOff];
            }
            succeed = YES;
        }
    }];
    return succeed;
}

#pragma mark - 切换摄像头
- (BOOL)convertCapturePosition {
    return [self setDeviceCapturePosition:(1 - self.capturePosition)];
}

- (BOOL)setDeviceCapturePosition:(MNCapturePosition)capturePosition {
    if (capturePosition == _capturePosition) return YES;
    /**切换到前置摄像头时, 关闭手电筒*/
    if (capturePosition == MNCapturePositionFront) {
        [self closeLighting];
    }
    if ([self convertDeviceCapturePosition:capturePosition]) {
        _capturePosition = capturePosition;
        return YES;
    }
    return NO;
}

- (BOOL)convertDeviceCapturePosition:(MNCapturePosition)position {
    if (!_session) return NO;
    NSError *error;
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:[self captureDeviceWithPosition:position] error:&error];
    if (error) return NO;
    _locking = YES;
    [self.session stopRunning];
    [self.session beginConfiguration];
    [self.session removeInput:_videoInput];
    if ([self.session canAddInput:videoInput]) {
        [self.session addInput:videoInput];
        self.videoInput = videoInput;
    }
    [self.session commitConfiguration];
    [self.session startRunning];
    _locking = NO;
    return YES;
}

#pragma mark - 获取照片
- (void)captureStillImageAsynchronously:(void(^)(UIImage *))completion {
    if (!self.imageOutput) {
        if (completion) completion(nil);
        return;
    }
    AVCaptureConnection *captureConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
        if (error || imageDataSampleBuffer == NULL) {
            if (completion) completion(nil);
            return;
        }
        NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:data];
        image = [image resizingOrientation];
        if (completion) completion(image);
    }];
}

#pragma mark - 对焦
- (BOOL)setFocusPoint:(CGPoint)point {
    if (!_videoInput || !_videoLayer || !_session.isRunning) return NO;
    CGPoint focus = [_videoLayer captureDevicePointOfInterestForPoint:point];
    __block BOOL succeed = NO;
    [self changeDeviceConfigurationHandler:^(AVCaptureDevice *device) {
        if ([device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([device isFocusPointOfInterestSupported]) {
            [device setFocusPointOfInterest:focus];
        }
        if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
            [device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([device isExposurePointOfInterestSupported]) {
            [device setExposurePointOfInterest:focus];
        }
    }];
    return succeed;
}

#pragma mark - 获取摄像头
- (AVCaptureDevice *)captureDeviceWithPosition:(MNCapturePosition)capturePosition {
    AVCaptureDevicePosition position = capturePosition == MNCapturePositionFront ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
    NSArray <AVCaptureDevice *>*devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

#pragma mark - 改变设备设置状态
- (void)changeDeviceConfigurationHandler:(void(^)(AVCaptureDevice *device))configurationHandler {
    if (!_session) return;
    AVCaptureDevice *device = [_videoInput device];
    if (!device) return;
    NSError *error;
    [_session beginConfiguration];
    if ([device lockForConfiguration:&error]) {
        configurationHandler(device);
        [device unlockForConfiguration];
    } else {
        NSLog(@"'change device configuration' error: %@",error.localizedDescription);
    }
    [_session commitConfiguration];
}

#pragma mark - 发生错误
- (void)captureFailureWithDescription:(NSString *)message {
    [self captureFailureWithCode:AVErrorScreenCaptureFailed description:message];
}

- (void)captureFailureWithCode:(NSUInteger)code description:(NSString *)description{
    [self captureFailureWithError:[NSError errorWithDomain:AVFoundationErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:description}]];
}

- (void)captureFailureWithError:(NSError *)error {
    __weak typeof(self)weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakself.error = error;
        if ([weakself.delegate respondsToSelector:@selector(capturerDidEndWithError:)]) {
            [weakself.delegate capturerDidEndWithError:weakself];
        }
    });
}

#pragma mark - Notification
- (void)didEnterBackgroundNotification {
    [self stopRunning];
    [self stopCapturing];
    [self closeLighting];
}

- (void)willEnterForegroundNotification {
    [self startRunning];
}

#pragma mark - Setter
- (void)setOutputView:(UIView *)outputView {
    if (!outputView) return;
    _outputView = outputView;
    if (!_session) return;
    AVLayerVideoGravity videoGravity = self.videoLayerGravity;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.videoLayer removeFromSuperlayer];
        self.videoLayer.frame = outputView.bounds;
        self.videoLayer.videoGravity = videoGravity;
        [outputView.layer insertSublayer:self.videoLayer atIndex:0];
    });
}

- (AVLayerVideoGravity)videoLayerGravity {
    if (_resizeMode == MNCaptureResizeModeResize) {
        return AVLayerVideoGravityResize;
    } else if (_resizeMode == MNCaptureResizeModeResizeAspect) {
        return AVLayerVideoGravityResizeAspect;
    }
    return AVLayerVideoGravityResizeAspectFill;
}

- (void)setResizeMode:(MNCaptureResizeMode)resizeMode {
    if (_capturing || resizeMode == _resizeMode) return;
    _resizeMode = resizeMode;
    _videoLayer.videoGravity = [self videoLayerGravity];
}

- (void)setOutputPath:(NSString *)outputPath {
    if (self.isCapturing || outputPath.pathExtension.length <= 0) return;
    [NSFileManager.defaultManager removeItemAtPath:outputPath error:nil];
    /// 只创建文件夹路径, 文件由数据写入时自行创建<踩坑总结>
    if ([NSFileManager.defaultManager createDirectoryAtPath:outputPath.stringByDeletingLastPathComponent withIntermediateDirectories:YES attributes:nil error:nil]) {
        _outputPath = outputPath.copy;
    }
}

#pragma mark - Getter
- (AVCaptureSession *)session {
    if (!_session) {
        AVCaptureSession *session = [AVCaptureSession new];
        session.usesApplicationAudioSession = NO;
        session.sessionPreset = [session canSetSessionPreset:AVCaptureSessionPresetHigh] ? AVCaptureSessionPresetHigh : AVCaptureSessionPresetMedium;
        _session = session;
    }
    return _session;
}

- (AVCaptureVideoPreviewLayer *)videoLayer {
    if (!_videoLayer) {
        AVCaptureVideoPreviewLayer *videoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _videoLayer = videoLayer;
    }
    return _videoLayer;
}

- (BOOL)isRunning {
    return (_session && _session.isRunning);
}

- (Float64)duration {
    if (self.isCapturing || ![NSFileManager.defaultManager fileExistsAtPath:self.outputPath]) return 0.f;
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:self.outputPath] options:@{AVURLAssetPreferPreciseDurationAndTimingKey:@YES}];
    if (!asset) return 0.f;
    return CMTimeGetSeconds(asset.duration);
}

- (NSInteger)frameRate {
    return MIN(30, MAX(_frameRate, 15));
}

- (MNCapturePresetName)presetName {
    return [_presetName hasPrefix:@"com.mn.capture."] ? _presetName : MNCapturePresetMediumQuality;
}

- (NSDictionary *)videoSettings {
    CGSize renderSize = MNCaptureIsEmptySize(self.outputView.bounds.size) ? UIScreen.mainScreen.bounds.size : self.outputView.bounds.size;
    float scale = UIScreen.mainScreen.scale;
    renderSize = CGSizeMake(renderSize.width*scale, renderSize.height*scale);
    CGFloat bitRate = renderSize.width*renderSize.height*self.videoBitRateRatio;
    /// 码率和帧率设置
    NSDictionary *compressionSetting = @{AVVideoAverageBitRateKey:@(bitRate), AVVideoExpectedSourceFrameRateKey:@(self.frameRate), AVVideoMaxKeyFrameIntervalKey:@(self.frameRate/2.f), AVVideoProfileLevelKey:AVVideoProfileLevelH264MainAutoLevel};
    return @{AVVideoWidthKey:@(renderSize.width), AVVideoHeightKey:@(renderSize.height), AVVideoCodecKey:AVVideoCodecH264, AVVideoScalingModeKey:AVVideoScalingModeResizeAspectFill, AVVideoCompressionPropertiesKey:compressionSetting};
}

- (NSDictionary *)audioSettings {
    if (!_audioSettings) {
        _audioSettings = @{AVEncoderBitRatePerChannelKey:@(28000), AVFormatIDKey:@(kAudioFormatMPEG4AAC), AVNumberOfChannelsKey:@(1), AVSampleRateKey:@(22050)};
        /*
        AudioChannelLayout channelLayout = {
            .mChannelLayoutTag = kAudioChannelLayoutTag_Stereo,
            .mChannelBitmap = kAudioChannelBit_Left,
            .mNumberChannelDescriptions = 0
        };
        NSData *channelLayoutData = [NSData dataWithBytes:&channelLayout length:offsetof(AudioChannelLayout, mChannelDescriptions)];
        _audioSettings = @{AVFormatIDKey:@(kAudioFormatMPEG4AAC),
                                   AVSampleRateKey:@(44100),
                                   AVNumberOfChannelsKey:@(2),
                                   AVChannelLayoutKey:channelLayoutData};
         */
    }
    return _audioSettings;
}

- (float)videoBitRateRatio {
    float bitRateRatio = 3.5f;
    MNCapturePresetName presetName = self.presetName;
    if ([presetName isEqualToString:MNCapturePresetLowQuality]) {
        bitRateRatio = 2.5f;
    } else if ([presetName isEqualToString:MNCapturePresetMediumQuality]) {
        bitRateRatio = 3.f;
    }
    return bitRateRatio;
}

#pragma mark - dealloc
- (void)dealloc {
    _delegate = nil;
    [self closeLighting];
    [self stopRunning];
    [self stopCapturing];
    [_videoLayer removeFromSuperlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MNDeallocLog;
}

@end
