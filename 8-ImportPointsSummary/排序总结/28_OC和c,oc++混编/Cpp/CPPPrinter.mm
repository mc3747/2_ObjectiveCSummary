//
//  CPPPrinter.cpp
//  CrossCompileDemo
//
//  Created by SamirChen on 12/26/16.
//  Copyright © 2016 CX. All rights reserved.
//

#include "CPPPrinter.h"
#import <iostream>
#include <typeinfo>

using namespace std;

namespace CPPPrinter {
    void sayHello() {
        printf("%s, %s, %d\n", __FILE__, __func__, __LINE__);
    };

    void printType(id input){
//    int i;
//    float f;
//    double d;
//    char c;
//    std::cout<< "i的类型是：" << typeid(i).name() <<std::endl;
//    std::cout<< "f的类型是：" << typeid(f).name() <<std::endl;
//    std::cout<< "d的类型是：" << typeid(d).name() <<std::endl;
//    std::cout<< "c的类型是：" << typeid(c).name() <<std::endl;
    std::cout<< "任意数据的类型是：" << typeid(input).name() <<std::endl;
        
        
        const type_info &nInfo = typeid(input);
        cout<<nInfo.name()<<"|"<<endl;
    };
    
    CPPPrinter::CPPPrinter() {
        printf("%s, %s, %d\n", __FILE__, __func__, __LINE__);
    }
    
    CPPPrinter::~CPPPrinter() {
        printf("%s, %s, %d\n", __FILE__, __func__, __LINE__);
    }
    
    void CPPPrinter::sayHello() {
        printf("%s, %s, %d\n", __FILE__, __func__, __LINE__);
    }
    
}
