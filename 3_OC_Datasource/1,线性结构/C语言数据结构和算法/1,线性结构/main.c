//
//  main.c
//  1,线性结构
//
//  Created by gjfax on 2017/12/18.
//  Copyright © 2017年 macheng. All rights reserved.
//

#include <stdio.h>
#include "double_link.h"

#pragma mark -双向链表操作int数据
 void int_test()
 {
        int iarr[4] = {10, 20, 30, 40};
        create_dlink();        // 创建双向链表
        dlink_insert(0, &iarr[0]);    // 向双向链表的表头插入数据
        dlink_insert(0, &iarr[1]);    // 向双向链表的表头插入数据
        dlink_insert(0, &iarr[2]);    // 向双向链表的表头插入数据
    
        printf("dlink_is_empty()=%d\n", dlink_is_empty());    // 双向链表是否为空
        printf("dlink_size()=%d\n", dlink_size());            // 双向链表的大小
    
       // 打印双向链表中的全部数据
        int i;
        int *p;
        int sz = dlink_size();
        for (i=0; i<sz; i++)
            {
                    p = (int *)dlink_get(i);
                    printf("dlink_get(%d)=%d\n", i, *p);
                }
    
         destroy_dlink();
     }

#pragma mark -演示向双向链表操作“字符串数据”
 void string_test()
 {
      char* sarr[4] = {"ten", "twenty", "thirty", "forty"};
       create_dlink();        // 创建双向链表
    
       dlink_insert(0, sarr[0]);    // 向双向链表的表头插入数据
       dlink_insert(0, sarr[1]);    // 向双向链表的表头插入数据
       dlink_insert(0, sarr[2]);    // 向双向链表的表头插入数据
    
       printf("dlink_is_empty()=%d\n", dlink_is_empty());    // 双向链表是否为空
       printf("dlink_size()=%d\n", dlink_size());            // 双向链表的大小
    
        // 打印双向链表中的全部数据
        int i;
        char *p;
        int sz = dlink_size();
        for (i=0; i<sz; i++)
           {
                    p = (char *)dlink_get(i);
                    printf("dlink_get(%d)=%s\n", i, p);
                }
    
        destroy_dlink();
}


#pragma mark -向双向链表的表头插入数据
//结构体
typedef struct tag_stu
{
    int id;
    char name[20];
}stu;
//结构体数组
static stu arr_stu[] =
{
    {10, "sky"},
    {20, "jody"},
    {30, "vic"},
    {40, "dan"},
};
//插入结构体对象
 void object_test()
 {
       create_dlink();    // 创建双向链表
       dlink_insert(0, &arr_stu[0]);    // 向双向链表的表头插入数据
       dlink_insert(0, &arr_stu[1]);    // 向双向链表的表头插入数据
       dlink_insert(0, &arr_stu[2]);    // 向双向链表的表头插入数据
    
        printf("dlink_is_empty()=%d\n", dlink_is_empty());    // 双向链表是否为空
        printf("dlink_size()=%d\n", dlink_size());            // 双向链表的大小
    
        // 打印双向链表中的全部数据
        int i;
        int sz = dlink_size();
        stu *p;
        for (i=0; i<sz; i++)
            {
                    p = (stu *)dlink_get(i);
                    printf("dlink_get(%d)=[%d, %s]\n", i, p->id, p->name);
               }
    
        destroy_dlink();
    }

#pragma mark -  main函数
int main(int argc, const char * argv[]) {
    
//    int_test();        // 演示向双向链表操作“int数据”。
//    string_test();    // 演示向双向链表操作“字符串数据”。
    object_test();    // 演示向双向链表操作“对象”。
    return 0;
}
