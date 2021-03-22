//
//  SandBoxVC.m
//  NetworkSummary
//
//  Created by gjfax on 2018/11/15.
//  Copyright © 2018 macheng. All rights reserved.
//

#import "SandBoxVC.h"

@interface SandBoxVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextView *textView3;
@property (weak, nonatomic) IBOutlet UITextView *textView4;
@property (weak, nonatomic) IBOutlet UITextView *textView5;
@property (weak, nonatomic) IBOutlet UITextView *textView6;
@property (weak, nonatomic) IBOutlet UITextView *textView7;
@property (weak, nonatomic) IBOutlet UITextView *textView8;


@end

@implementation SandBoxVC
// =====================================================
// 1，app安装到苹果手机上，会产生两个路径 ，分别为.app(应用程序安装目录)和应用程序的沙盒（应用程序保存数据的目录，如应用配置信息、缓存的文件等）
// 2，每个沙盒含有3个文件夹：Documents, Library 和 tmp
// 3， Documents：苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
//Library：存储程序的默认设置或其它状态信息，其中又包含了Caches文件夹和Preferences文件夹
//Library/Caches：存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出时删除
//Library/Preferences：存放偏好设置的plist文件
//tmp：提供一个即时创建临时文件的地方：iTunes在与iPhone同步时，会备份所有的Documents和Library文件。iPhone在重启时，会丢弃所有的tmp文件。
// =====================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showText1];
    [self showText2];
    [self showText3];
    [self showText4];
    [self showText5];
    [self showText6];
    [self showText7];
    [self showText8];
}

// =====================================================
// bundle目录：即app的目录，
// 该目录包含了应用程序本身的数据，包括资源文件和可执行文件等。整个目录是只读的，并且不会被 iTunes 同步
// =====================================================
- (void)showText1 {
    NSString *appPath=[[NSBundle mainBundle]bundlePath];
    _textView1.text = [NSString stringWithFormat:@"✅1,app的路径✅：%@",appPath];
    NSLog(@"app路径：%@",appPath);
}

// =====================================================
// 沙盒目录（应用程序保存数据的目录，如应用配置信息、缓存的文件等）
// =====================================================
- (void)showText2 {
    NSString *sandboxPath = NSHomeDirectory();
    _textView2.text = [NSString stringWithFormat:@"✅2,沙盒的路径✅：%@",sandboxPath];
    NSLog(@"沙盒路径：%@",sandboxPath);
}

// =====================================================
//  我们可以将应用程序的数据文件保存在该目录下。不过这些数据类型仅限于不可再生的数据，该目录会被iTunes同步
//  NSSearchPathForDirectoriesInDomains方法用来取得当前程序沙盒中的文件路径，第一个参数设置检索的指定路径名，第二个参数设定检索范围，第三个参数设置是否展开波浪线符号（展开波浪线符号才是完整的路径，所以常设置为YES），方法返回值为一个数组，由于不同的参数返回的路径个数不统一，所以为了接口的统一性，设置返回值为数组
// =====================================================
- (void)showText3 {
    NSArray *documentsArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsArr objectAtIndex:0];
    _textView3.text = [NSString stringWithFormat:@"✅3,Documents文件夹的路径✅：%@",documentsPath];
}

// =====================================================
// library：存放默认设置或其它状态信息。除了 Caches 子目录外其他目录都会被 iTunes 同步
// =====================================================
- (void)showText4 {
    NSArray *libraryArr =NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *LibraryPath = [libraryArr objectAtIndex:0];
    _textView4.text = [NSString stringWithFormat:@"✅4,Library文件夹的路径✅：%@",LibraryPath];
}

// =====================================================
// Library/Caches: iTunes 不会同步此文件夹，并且当系统空间不足的时候会被清理，适合存储体积大，不需要备份的非重要数据
// =====================================================
- (void)showText5 {
    NSArray *cachesArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [cachesArr objectAtIndex:0];
     _textView5.text = [NSString stringWithFormat:@"✅5,Library/Cash文件夹的路径✅：%@",cachesPath];
}

// =====================================================
// tmp/：各种临时文件，保存应用再次启动时不需要的文件。而且，当应用不再需要这些文件时应该主动将其删除，因为该目录下的东西随时有可能被系统清理掉，目前已知的一种可能清理的原因是系统磁盘存储空间不足的时候
// =====================================================
- (void)showText6 {
    NSString *tmpPath = NSTemporaryDirectory();
    _textView6.text = [NSString stringWithFormat:@"✅6,tmp文件夹的路径✅：%@",tmpPath];
    
}

// =====================================================
// Create groups方式，图片直接在.app里，以下两种方式相同
// =====================================================
- (void)showText7 {
    NSString *path1=[[NSBundle mainBundle]pathForResource:@"101" ofType:@"png"];
    NSString *path2=[[NSBundle mainBundle]pathForResource:@"101.png" ofType:nil];
    _textView7.text = [NSString stringWithFormat:@"✅7,目录逻辑文件夹的路径✅：%@",path1];
}

// =====================================================
// Create folder reference方式，图片在img文件夹里里，以下三种方式相同
// =====================================================
- (void)showText8 {
    NSString *path3=[[NSBundle mainBundle]pathForResource:@"1" ofType:@"png" inDirectory:nil];
    NSString *path4=[[NSBundle mainBundle]pathForResource:@"1.png" ofType:nil inDirectory:@"img"];
    NSString *path5=[[NSBundle mainBundle]pathForResource:@"img/1.png" ofType:nil inDirectory:nil];
    _textView8.text = [NSString stringWithFormat:@"✅8,沙盒实际文件夹的路径✅：%@",path3];
    
}

@end
