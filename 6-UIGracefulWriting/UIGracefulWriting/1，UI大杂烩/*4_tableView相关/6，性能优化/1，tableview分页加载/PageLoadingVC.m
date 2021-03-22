//
//  PageLoadingVC.m
//  UIGracefulWriting
//
//  Created by gjfax on 2019/2/18.
//  Copyright © 2019 macheng. All rights reserved.
//

#import "PageLoadingVC.h"

@interface PageLoadingVC ()

@end

@implementation PageLoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subtitleArray = @[@[@"点击分页",@"下拉分页"]];
    self.vcNameArray = @[@[@"PageLoadingDemo1VC",@"PageLoadingDemo2VC"]];
}

#pragma mark -  本质
/*
 参考：https://www.jianshu.com/p/59a28a0a88aa
 快速： 后端资源全是 CDN 分发
 准确：
 */
#pragma mark -  1，基于偏移的分页：http://XXXXXXXlist?page=1&count=20
/*
 可以直接根据页码跳转到特定页
 可能会出现重复、丢失数据的情况
 页数较大时性能会降低
 排序条件与分页无关
 */

#pragma mark -  2，基于游标分页方案:facebook
/*
 不可以直接跳转到特定页（知道页数），但是可以直接跳转到最后一页，能加载下一页，上一页。
 不会出现重复、丢失数据的情况
 查询效率与页数无关，并且优于传统分页
 不适合排序条件比较复杂的分页
 */

#pragma mark -  3，基于时间的分页:新浪微博

#pragma mark -  4，整体缓存方案
/*
 1、基于偏移的分页方案  会有数据重复加载到，需要做好去重工作。
 2、基于游标的分页方案  有数据连续性的问题。
 例如 第一次 缓存 10-0 条，第二次 缓存了 30-20 条记录。 第三次 打开 如果请求的数据 能 接上 第30条，则没问题。但是 缓存的 10-0 条记录 就断掉了。
 所以：
 A）如果 80% 的访问量 都是第一页的数据，例如最新的 20条 或者 40条 记录，则可以 只缓存 第一页的数据。
 例如  新浪微博。
 B）把每次断掉的 id 都缓存起来。等加载到的时候再连上。
 C）自己想到的方案：客户端只缓存最新的连续数据。
 
 每次请求服务器的时候，都带上最新的id（since_id）和最老的 id（max_id)。加载更多 或者 下拉刷新时，如果可以和缓存连接上，则同时返回 since_id 和 max_id 之间 变化的数据（例如删除了某一条），客户端做处理。
 下拉刷新时，假如本来一页是返回10条数据，但是实际上只有11or12条数据
 
 采用预加载分页
 
 */


@end
