//
//  UIWindow+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/10.
//

#import "UIWindow+AshUserAutoTracking.h"
#import "NSObject+AshUserAutoTracking.h"
#import "UIResponder+AshUserAutoTracking.h"
#import "UIViewController+AshUserAutoTracking.h"

@implementation UIWindow (AshUserAutoTracking)

+(void)load {
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(setRootViewController:) exchangeSEL:@selector(AshUserAutoTracking_setRootViewController:)];
}

-(void)AshUserAutoTracking_setRootViewController:(UIViewController *)rootViewController {
    NSUInteger windowIndex = [[UIApplication sharedApplication].windows indexOfObject:self];
    NSString *route = [NSString stringWithFormat:@"windows[%lu].%@",
                       windowIndex,
                       [rootViewController AshTrackingRename]];
    [rootViewController setAshTrackingRoute:route];
    [self AshUserAutoTracking_setRootViewController:rootViewController];
}

@end
