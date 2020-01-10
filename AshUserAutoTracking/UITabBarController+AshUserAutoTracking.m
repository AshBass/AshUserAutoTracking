//
//  UITabBarController+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import "UITabBarController+AshUserAutoTracking.h"
#import "NSObject+AshUserAutoTracking.h"
#import "UIResponder+AshUserAutoTracking.h"
#import "AshUserAutoTrackingDelegate.h"
#import <objc/runtime.h>

@implementation UITabBarController (AshUserAutoTracking)

+(void)load {
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(setDelegate:) exchangeSEL:@selector(AshUserAutoTracking_setDelegate:)];
}

-(void)AshUserAutoTracking_setDelegate:(id<UITabBarControllerDelegate>)delegate {
    if ([delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        AshUserAutoTrackingDelegate *trackingDelegate = [[AshUserAutoTrackingDelegate alloc] init];
            trackingDelegate.delegate = delegate;
    }
    [self AshUserAutoTracking_setDelegate:delegate];
}

-(void)setAshTrackingRoute:(NSString *)AshTrackingRoute {
    for (UIViewController *vc in self.viewControllers) {
        @autoreleasepool {
            NSString *route = [NSString stringWithFormat:@"%@%@",
                               AshTrackingRoute,
                               [vc AshTrackingRoute]];
            [vc setAshTrackingRoute:route];
        }
    }
}

@end
