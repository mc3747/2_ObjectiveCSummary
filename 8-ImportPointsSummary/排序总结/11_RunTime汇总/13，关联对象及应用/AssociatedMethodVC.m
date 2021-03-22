//
//  AssociatedMethodVC.m
//  排序总结
//
//  Created by gjfax on 2020/1/10.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "AssociatedMethodVC.h"
#import "UIImagePickerController+RFBlocks.h"
#import "UIButton+RFBlcoks.h"
#import "UIViewController+RFPresentPopover.h"
// =====================================================
/*
 1，核心函数3个 -- 允许将任何键值在允许时关联到对象上，即可以对已经存在的类在扩展中添加自定义的属性

 objc_setAssociatedObject
 objc_getAssociatedObject
 objc_removeAssociatedObjects

 2，实现的3种方式
    static char
    selector
    _cmd_
 详细例子见NSObject+AssociatedObject
 
 3，属性根据枚举类型objc_AssociationPolicy来决定被关联在对象上的行为
 Behavior                                   与之等效的@property
 OBJC_ASSOCIATION_ASSIGN                @property (assign) 或@property (unsafe_unretained)
 OBJC_ASSOCIATION_RETAIN_NONATOMIC      @property (nonatomic, strong)
 OBJC_ASSOCIATION_COPY_NONATOMIC        @property (nonatomic, copy)
 OBJC_ASSOCIATION_RETAIN                @property (atomic, strong)
 OBJC_ASSOCIATION_COPY                  @property (atomic, copy)

 4，对象销毁时间
被关联的对象在声明周期内比对象本身释放要晚很多，在对象调用-dealloc中的object_dispose()中释放
 
 5，删除属性
 你或许想要使用objc_removeAssociatedObjects（）来进行删除操作，但官方文档不建议手动调用这个函数。
 这个函数可能会把其他用户对其添加的属性也移除了，正确的方式是调用objc_setAssociatedObject方法，传入nil值来清楚一个关联

 */
// =====================================================
@interface AssociatedMethodVC ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation AssociatedMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)showImagePicker:(id)sender {
    [self test1];
}
- (void)test1
{
    __weak typeof(self)weakSelf = self;
    
    UIImagePickerController *picker =  [UIImagePickerController rf_imagePickerWithFinishBlock:^(NSDictionary *info) {
        NSLog(@"finish picke image\n info:%@",info);
        
        UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
        weakSelf.view.layer.contents = (id)img.CGImage;
    }];
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)test2
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    __weak typeof(self)weakSelf = self;
    
    picker.rf_finishBlock = ^(NSDictionary *info) {
        NSLog(@"finish picke image\n info:%@",info);
        
        UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
        weakSelf.view.layer.contentsGravity = kCAGravityResizeAspect;
        weakSelf.view.layer.contents = (id)img.CGImage;
    };
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)showButtonBlock:(id)sender {
    self.button.rf_buttonClickBlock = ^(UIButton *button){
            NSLog(@"%@ clicked",button);
    };
}

//在ipad上的例子，点击会崩溃
- (IBAction)showPoperView:(id)sender {
    UIViewController *vc = [UIViewController new];
      vc.view.backgroundColor = [UIColor orangeColor];
      
      [self rf_presentPopoverWithViewController:vc fromRect:self.button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

@end
