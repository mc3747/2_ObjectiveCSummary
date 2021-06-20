//
//  CPPPrinter.hpp
//  CrossCompileDemo
//
//  Created by SamirChen on 12/26/16.
//  Copyright © 2016 CX. All rights reserved.
//

#ifndef CPPPrinter_h
#define CPPPrinter_h

#include <stdio.h>
//#include <iostream>

using namespace std;

namespace CPPPrinter {
    void sayHello();
    void printType(id input);

    class CPPPrinter {
    public:
        CPPPrinter();
        ~CPPPrinter();
        void sayHello();
    };
}

#endif /* CPPPrinter_hpp */
