//
//  NSObject+Test.m
//  isa和superclass1
//
//  Created by 赵鹏 on 2019/5/3.
//  Copyright © 2019 赵鹏. All rights reserved.
//

#import "NSObject+Test.h"

@implementation NSObject (Test)

//+ (void)test
//{
//    NSLog(@"+[NSObject test] - %p", self);
//}

- (void)test
{
    NSLog(@"-[NSObject test] - %p", self);
}

@end
