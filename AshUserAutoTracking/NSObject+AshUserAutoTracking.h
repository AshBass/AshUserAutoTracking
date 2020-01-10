//
//  NSObject+AshUserAutoTracking.h
//  Pods
//
//  Created by Harry Houdini on 2020/1/8.
//

#import <Foundation/Foundation.h>

@interface NSObject (AshUserAutoTracking)

+(void)AshUserAutoTracking_exchangeClassMethod:(Class)aClass originalSEL:(SEL)originalSEL exchangeSEL:(SEL)exchangeSEL;
+(void)AshUserAutoTracking_exchangeInstanceMethod:(Class)aClass originalSEL:(SEL)originalSEL exchangeSEL:(SEL)exchangeSEL;

@end
