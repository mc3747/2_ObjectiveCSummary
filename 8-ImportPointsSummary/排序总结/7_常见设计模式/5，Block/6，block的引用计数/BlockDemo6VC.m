//
//  BlockDemo6VC.m
//  排序总结
//
//  Created by gjfax on 2020/1/10.
//  Copyright © 2020 macheng. All rights reserved.
//

#import "BlockDemo6VC.h"
// =====================================================
/*
 TableBlock
 */
// =====================================================
typedef void (^AddCellBlock)(void);

@interface TableBlock : NSObject
@property (nonatomic,copy)AddCellBlock addCell;
-(void)reloadData;
@end
@implementation TableBlock
- (void)setAddCell:(AddCellBlock)addCell {
    __weak AddCellBlock addCellWeak=addCell;
    _addCell=addCellWeak;
}

-(void)reloadData
{
    if(self.addCell)
    {
        self.addCell();
        self.addCell();//没事来两次，模拟table多次循环清加cell
    }
}

-(void)dealloc
{
    NSLog(@"TableBlock释放");//relase为错误字，为了和下图保持一致的错别字，这里就不改了。
}
@end

// =====================================================
/*
 主控制器
 */
// =====================================================
@interface BlockDemo6VC ()
@property (nonatomic, copy) TableBlock *tableBlock;
@end

@implementation BlockDemo6VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)start {
    TableBlock *tableBlock = [[TableBlock alloc] init];
    tableBlock.addCell = ^{
        __weak typeof (tableBlock)weakTableBlock = tableBlock;
    };
//    tableBlock.addCell = nil;
    NSLog(@"tableBlock引用计数为%ld",CFGetRetainCount((__bridge CFTypeRef)(tableBlock)));
    _tableBlock = tableBlock;
    
}
#pragma mark -  点击，查看引用计数
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self start];
}

- (void)dealloc {
     NSLog(@"tableBlock的引用计数为%ld",CFGetRetainCount((__bridge CFTypeRef)(_tableBlock)));
     NSLog(@"view的引用计数为%ld",CFGetRetainCount((__bridge CFTypeRef)(self.view)));
}

@end
