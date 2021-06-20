//
//  CommonFontDefine.h
//  IOS_KnowledgePoints
//
//  Created by gjfax on 2017/12/28.
//  Copyright © 2017年 macheng. All rights reserved.
//

#ifndef CommonFontDefine_h
#define CommonFontDefine_h

// 通用字体宏
#define CommonSystemFont(x) [UIFont systemFontOfSize:x]
#define Common10SystemFont  [UIFont systemFontOfSize:kCommonFontSizeSmall_10]
#define Common12SystemFont  [UIFont systemFontOfSize:kCommonFontSizeSubSubDesc_12]
#define Common14SystemFont  [UIFont systemFontOfSize:kCommonFontSizeSubDesc_14]
#define Common16SystemFont  [UIFont systemFontOfSize:kCommonFontSizeDetail_16]
#define Common18SystemFont  [UIFont systemFontOfSize:kCommonFontSizeTitle_18]
#define Common20SystemFont  [UIFont systemFontOfSize:kCommonFontSizeNaviTitle_20]
#define Common25SystemFont  [UIFont systemFontOfSize:kCommonFontSizeBtnTitle_25]
#define Common30SystemFont  [UIFont systemFontOfSize:kCommonFontSizeHighlight_30]
#define Common64SystemFont  [UIFont systemFontOfSize:kCommonFontXSize_64]

//  通用字体大小
static CGFloat const kCommonFontXSize_64 = 32.0f;
static CGFloat const kCommonFontSizeHighlight_30 = 30.0f;
static CGFloat const kCommonFontSizeBtnTitle_25 = 25.0f;
static CGFloat const kCommonFontSizeNaviTitle_20 = 20.0f;
static CGFloat const kCommonFontSizeTitle_18 = 18.0f;
static CGFloat const kCommonFontSizeDetail_16 = 16.0f;
static CGFloat const kCommonFontSizeSubDesc_14 = 14.0f;
static CGFloat const kCommonFontSizeSubSubDesc_12 = 12.0f;
static CGFloat const kCommonFontSizeSmall_10 = 10.0f;

#endif /* CommonFontDefine_h */
