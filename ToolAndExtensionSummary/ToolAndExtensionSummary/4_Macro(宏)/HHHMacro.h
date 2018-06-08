//
//  HHHMacro.h
//  ToolAndExtensionSummary
//
//  Created by gjfax on 2018/6/8.
//  Copyright © 2018年 macheng. All rights reserved.
//

#ifndef HHHMacro_h
#define HHHMacro_h

#define FMT_STR(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

#define FMT_STRING( ...) [NSString stringWithFormat:@"%@", ##__VA_ARGS__]

#endif /* HHHMacro_h */
