//
//  double_link.h
//  1,线性结构
//
//  Created by gjfax on 2017/12/18.
//  Copyright © 2017年 macheng. All rights reserved.
//

#ifndef double_link_h
#define double_link_h

#include <stdio.h>

 // 新建“双向链表”。成功，返回表头；否则，返回NULL
extern int create_dlink(void);
 // 撤销“双向链表”。成功，返回0；否则，返回-1
extern int destroy_dlink(void);

 // “双向链表是否为空”。为空的话返回1；否则，返回0。
extern int dlink_is_empty(void);
 // 返回“双向链表的大小”
extern int dlink_size(void);

 // 获取“双向链表中第index位置的元素”。成功，返回节点指针；否则，返回NULL。
 extern void* dlink_get(int index);
 // 获取“双向链表中第1个元素”。成功，返回节点指针；否则，返回NULL。
extern void* dlink_get_first(void);
 // 获取“双向链表中最后1个元素”。成功，返回节点指针；否则，返回NULL。
extern void* dlink_get_last(void);

 // 将“value”插入到index位置。成功，返回0；否则，返回-1。
 extern int dlink_insert(int index, void *pval);
// 将“value”插入到表头位置。成功，返回0；否则，返回-1。
 extern int dlink_insert_first(void *pval);
// 将“value”插入到末尾位置。成功，返回0；否则，返回-1。
 extern int dlink_append_last(void *pval);

 // 删除“双向链表中index位置的节点”。成功，返回0；否则，返回-1
extern int dlink_delete(int index);
// 删除第一个节点。成功，返回0；否则，返回-1
extern int dlink_delete_first(void);
extern int dlink_delete_last(void);

#endif /* double_link_h */
