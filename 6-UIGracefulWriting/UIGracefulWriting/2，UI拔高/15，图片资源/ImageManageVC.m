//
//  ImageManageVC.m
//  UIGracefulWriting
//
//  Created by kk on 2021/4/16.
//  Copyright © 2021 macheng. All rights reserved.
//

#import "ImageManageVC.h"

@interface ImageManageVC ()

@end

@implementation ImageManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//参考文章链接：https://blog.csdn.net/Z1591090/article/details/88355955
#pragma mark - 1，xcasset图片
/*
 1，只能用imageNamed方法加载（内存加载图片）
 2，每个文件夹生成其中图片的描述文件json，
    高度优化的特殊格式Image Set来加载图片
 3，减少频繁的磁盘IO操作
 4，按照不同的机型分辨率来加载
 5，更加安全，有一定程度的保护
 6，应用：
    加载频繁使用的小图标
 */
-(UIImage *)showImage1{
    return [UIImage imageNamed:@"LaunchImage"];
}

/*
 1，可以用imageWithContentsOfFile方法加载（磁盘加载图片）
 2，imageWithContentsOfFile 创建的对象，每次都会重新申请内存，相同图片不会缓存
 3，手动写@2x，@3x
 4，加载完成后，会进行回收，减少内存占用
 5，应用：
    加载偶尔使用的大图标（引导页大图标）
 */
#pragma mark - 2，直接拖拽到工程图片
-(void)showImage2{
    
}

/*
 1，bundle资源包：许多图片，xib，文本文件等
 2，应用：
    使用频率低的可以建立一个bundle存放图片,使用imageWithContentsOfFile加载
    在第三方库中经常使用
 */
#pragma mark - 3，打包成bundle图片
-(void)showImage3{
    
}


#pragma mark - 4，沙盒文件目录图片
-(void)showImage4{
    
}
@end
