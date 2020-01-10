//
//  NSObject+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/8.
//

#import "NSObject+AshUserAutoTracking.h"
#import <objc/runtime.h>

@implementation NSObject (AshUserAutoTracking)

+(void)AshUserAutoTracking_exchangeClassMethod:(Class)aClass originalSEL:(SEL)originalSEL exchangeSEL:(SEL)exchangeSEL {
    Method originalMethod = class_getClassMethod(aClass, originalSEL);
    Method exchangeMethod = class_getClassMethod(aClass, exchangeSEL);
    if (originalMethod && exchangeMethod) {
        method_exchangeImplementations(originalMethod, exchangeMethod);
    }
}

+(void)AshUserAutoTracking_exchangeInstanceMethod:(Class)aClass originalSEL:(SEL)originalSEL exchangeSEL:(SEL)exchangeSEL {
    Method originalMethod = class_getInstanceMethod(aClass, originalSEL);
    Method exchangeMethod = class_getInstanceMethod(aClass, exchangeSEL);
    if (originalMethod && exchangeMethod) {
        method_exchangeImplementations(originalMethod, exchangeMethod);
    }
}

@end
