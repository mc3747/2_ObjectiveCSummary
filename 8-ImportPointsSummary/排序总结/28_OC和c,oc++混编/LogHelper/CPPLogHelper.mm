//
//  CPPLogHelper.cpp
//  CrossCompileDemo
//
//  Created by qiufu on 12/27/16.
//  Copyright © 2016 CX. All rights reserved.
//

#include "CPPLogHelper.h"

namespace CPPLogHelper {
    
    void log() {
        printf("%s, %s, %d\n", __FILE__, __func__, __LINE__);
    }

}
