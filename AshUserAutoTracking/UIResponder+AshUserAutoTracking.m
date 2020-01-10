//
//  UIResponder+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import "UIResponder+AshUserAutoTracking.h"
#import <objc/runtime.h>

@implementation UIResponder (AshUserAutoTracking)

-(void)setAshTrackingRoute:(NSString *)AshTrackingRoute {
    NSString *route = [AshTrackingRoute copy];
    objc_setAssociatedObject(self, "AshTrackingRoute", route, OBJC_ASSOCIATION_COPY);
}

-(NSString *)AshTrackingRoute {
    NSString *route = objc_getAssociatedObject(self, "AshTrackingRoute");
    return route.length > 0 ? route : @"";
}

-(void)setAshTrackingRename:(NSString *)AshTrackingRename {
    NSString *name = [AshTrackingRename copy];
    objc_setAssociatedObject(self, "AshTrackingRename", name, OBJC_ASSOCIATION_COPY);
}

-(NSString *)AshTrackingRename {
    NSString *name = objc_getAssociatedObject(self, "AshTrackingRename");
    return name.length > 0 ? name : NSStringFromClass([self class]);
}

@end
