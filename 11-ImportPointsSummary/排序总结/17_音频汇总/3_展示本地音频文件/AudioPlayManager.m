//
//  AudioPlayManager.m
//  排序总结
//
//  Created by gjfax on 2018/10/29.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "AudioPlayManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface AudioPlayManager ()
@property (nonatomic, assign) SystemSoundID soundID;
@property (nonatomic, assign) BOOL isSoundForbidden;
@end

@implementation AudioPlayManager

#pragma mark -  单例
+ (instancetype)manager{
    static id _instance;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+ (void)playSystemSoundWith:(NSString *)fileName {
    AudioPlayManager *manager = [AudioPlayManager manager];
    [manager playSystemSoundWith:fileName];
}
+ (void)playSystemSoundWith:(NSString *)fileName fileType:(NSString *)fileType {
    AudioPlayManager *manager = [AudioPlayManager manager];
    [manager playSystemSoundWith:fileName fileType:fileType];
}
+ (void)playSelfdefinedSoundWith:(NSString *)fileName {
    AudioPlayManager *manager = [AudioPlayManager manager];
    [manager playSelfdefinedSoundInBundleWith:fileName];
}

+ (void)playSelfdefinedSoundWith:(NSString *)fileName fileType:(NSString *)fileType {
    AudioPlayManager *manager = [AudioPlayManager manager];
    [manager playSelfdefinedSoundInBundleWith:fileName fileType:fileType];
}

+ (void)playSelfdefinedSoundInDocumentWith:(NSString *)fileName {
    AudioPlayManager *manager = [AudioPlayManager manager];
    [manager playSelfdefinedSoundInDocumentWith:fileName];
}

+ (void)stopPlaySound {
     AudioPlayManager *manager = [AudioPlayManager manager];
     [manager stop];
}

#pragma mark -  系统音效1：文件全称
- (void)playSystemSoundWith:(NSString *)fileName {
    if (!_soundID) {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@",fileName];
        if (path) {
            // 注册系统文件
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&_soundID);
            
            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                _soundID = 0;
            }
        }
    };
    [self play];
}

#pragma mark -  系统音效2：文件名 + 类型
- (void)playSystemSoundWith:(NSString *)fileName fileType:(NSString *)fileType {
    if (!_soundID) {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",fileName,fileType];
        if (path) {
            // 注册系统文件
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&_soundID);
            
            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                _soundID = 0;
            }
        }
    };
    [self play];
}
#pragma mark -  自定义音效1：bundle文件全称
- (void)playSelfdefinedSoundInBundleWith:(NSString *)fileName {
    if (!_soundID) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        if (fileURL != nil)
        {
            //使用本地
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                _soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }else {
            //使用系统
            [self playSystemSoundWith: @"Tock" fileType:@"caf"];
        }
    };
     [self play];
}

#pragma mark -  自定义音效2：bundle文件名 + 类型
- (void)playSelfdefinedSoundInBundleWith:(NSString *)fileName fileType:(NSString *)fileType {
    if (!_soundID) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
        if (path) {
            //使用本地
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                _soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        } else {
            //使用系统
            [self playSystemSoundWith:@"Tock" fileType:@"caf"];
        }
    };
 [self play];
}
#pragma mark -  自定义音效3：沙盒文件
- (void)playSelfdefinedSoundInDocumentWith:(NSString *)fileName {
    if (!_soundID) {
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documents stringByAppendingPathComponent:fileName];
        if (path) {
            // 注册系统文件
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&_soundID);
            
            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                _soundID = 0;
            }
        }
    };
    [self play];
    
}
#pragma mark -  开启声音
- (void)play {
    AudioServicesPlaySystemSound(_soundID);
}

#pragma mark -  停止声音
- (void)stop {
    _soundID = 0;
}

#pragma mark -  销毁
- (void)dealloc {
    AudioServicesDisposeSystemSoundID(_soundID);
    
}
@end
