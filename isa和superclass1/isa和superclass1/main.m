//
//  main.m
//  isa和superclass1
//
//  Created by 赵鹏 on 2019/5/3.
//  Copyright © 2019 赵鹏. All rights reserved.
//

/**
 想要调用Runtime的API就先要在文件中引入"#include <objc/message.h>"头文件，然后在"TARGETS"中的"Build Settings"中搜索"msg"，在搜索结果中把"Enable Strict Checking of objc_msgSend Calls"由"Yes"改为"No"，否则无法调用相关的函数。最后再调用Runtime自己的API，例如："objc_msgSend()"；
 */

#import <Foundation/Foundation.h>
#import "NSObject+Test.h"
#include <objc/message.h>

//自定义类
@interface Person : NSObject

+ (void)test;

@end

@implementation Person

//+ (void)test
//{
//    NSLog(@"+[Person test] - %p", self);
//}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"[MJPerson class] - %p", [Person class]);
        NSLog(@"[NSObject class] - %p", [NSObject class]);
        
        /**
         ·当Person类中实现了test类方法，并且NSObject类中也实现了test类方法的时候，运行如下的代码，具体的调用流程为：系统根据Person类的class对象中的isa指针找到它的meta-class对象，并且在meta-class对象里面找到了test类方法，然后再进行调用；
         ·当Person类中没有实现test类方法，但是在NSObject类中实现了test类方法的时候，运行如下的代码，具体的调用流程为：系统根据Person类的class对象中的isa指针找到它的meta-class对象，但是该meta-class对象中没有找到test类方法，然后系统根据该meta-class对象里面的superclass指针找到Person类的父类（NSObject类）的meta-class对象，在NSObject类的meta-class对象中找到了test类方法，然后再进行调用；
         ·当Person类中没有实现test类方法，并且在NSObject类中也没有实现test类方法，但是在NSObject类中实现了test实例方法的时候，运行如下的代码，具体的调用流程为：系统根据Person类的class对象中的isa指针找到Person类的meta-class对象，在该meta-class对象中没有找到test类方法，然后系统再根据该meta-class对象中的superclass指针找到Person类的父类（NSObject类）的meta-class对象，系统在基类的meta-class对象中没有找到test类方法，然后系统再根据基类的meta-class对象中的superclass指针找到NSObject类的class对象，然后在NSObject类的class对象中找到了test实例方法，最后再进行调用，整个调用过程结束。
         ·下面的代码其实可以写成"objc_msgSend"的形式，从objc_msgSend可以看出，OC对象在调用方法的时候其实是不知道调用的是实例方法还是类方法的，只知道是给谁发消息，根据消息名一步一步地寻找，直到找到了为止。
         */
        [Person test];
//        objc_msgSend([Person class], @selector(test));
        
        /**
         下面代码的调用原理：系统会根据NSObject类的类对象里面的isa指针找到它的元类对象，看看该元类对象里面有没有test类方法，发现没有test类方法，然后根据该元类对象里面的superclass指针找到NSObject类的类对象，查看该类对象里面有没有test实例方法，发现有，然后就调用它。
         */
        [NSObject test];
//        objc_msgSend([NSObject class], @selector(test));
    }
    
    return 0;
}
