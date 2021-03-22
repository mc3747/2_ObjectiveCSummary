//
//  cprinter.c
//  CrossCompileDemo
//
//  Created by SamirChen on 12/26/16.
//  Copyright © 2016 CX. All rights reserved.
//

#include "cprinter.h"

void say_hello() {
    printf("%s, %s, %d\n", __FILE__, __func__, __LINE__);
}
