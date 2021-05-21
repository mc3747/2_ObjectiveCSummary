//
//  MNWarning.h
//  MNKit
//
//  Created by Vincent on 2018/8/1.
//  Copyright © 2018年 小斯. All rights reserved.
//  定义警告

#ifndef MNWarning_h
#define MNWarning_h

/**必须重写父类方法*/
#define MNKIT_REQUIRES_SUPER   __attribute__((objc_requires_super))

/**过期提醒 __attribute__((deprecated))*/
#ifdef DEPRECATED_ATTRIBUTE
#define MNKIT_DEPRECATED   DEPRECATED_ATTRIBUTE
#endif

/**过期提醒("msg"定义信息) __attribute((deprecated((msg))))*/
#ifdef DEPRECATED_MSG_ATTRIBUTE
#define MNKIT_DEPRECATED_MSG(_msg_)   DEPRECATED_MSG_ATTRIBUTE(_msg_)
#endif

/**不可用 或 UNAVAILABLE_ATTRIBUTE*/
#ifdef UNAVAILABLE_ATTRIBUTE
#define MNKIT_UNAVAILABLE   UNAVAILABLE_ATTRIBUTE
#endif

/**屏蔽版本警告*/
#define MNKIT_CLANG_AVAILABLE_PUSH  \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored\"-Wunguarded-availability\"")

/**屏蔽废弃警告*/
#define MNKIT_CLANG_DEPRECATED_PUSH  \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored\"-Wdeprecated-declarations\"")

/**屏蔽无用警告*/
#define MNKIT_CLANG_UNUSED_PUSH  \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored\"-Wunused-variable\"")

/**屏蔽 Block 无参数类型警告*/
#define MNKIT_CLANG_STRICT_PUSH  \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored\"-Wstrict-prototypes\"")

/**屏蔽缺少super调用类型警告*/
#define MNKIT_CLANG_MISS_SUPER_PUSH  \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored\"-Wobjc-missing-super-calls\"")

/**编译警告结束*/
#define MNKIT_CLANG_POP  \
_Pragma("clang diagnostic pop")

#endif /* MNWarning_h */
