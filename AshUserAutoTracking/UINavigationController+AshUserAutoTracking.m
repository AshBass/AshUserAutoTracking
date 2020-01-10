//
//  UINavigationController+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import "UINavigationController+AshUserAutoTracking.h"
#import "NSObject+AshUserAutoTracking.h"
#import "UIResponder+AshUserAutoTracking.h"
#import "UIViewController+AshUserAutoTracking.h"
#import <objc/runtime.h>

@implementation UINavigationController (AshUserAutoTracking)

+(void)load {
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(pushViewController:animated:) exchangeSEL:@selector(AshUserAutoTracking_pushViewController:animated:)];
}

-(void)AshUserAutoTracking_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSString *preViewControllerRoute = [NSString stringWithFormat:@"%@%@",
                                        [self.topViewController AshTrackingRoute],
                                        [self.topViewController AshTrackingLastActivity]];
    NSString *nowViewControllerRename = [viewController AshTrackingRename];
    NSString *route = [NSString stringWithFormat:@"%@/%@",preViewControllerRoute,nowViewControllerRename];
    
    [self.topViewController setAshTrackingLastActivity:nil];
    [viewController setAshTrackingRoute:route];
    
    [self AshUserAutoTracking_pushViewController:viewController animated:animated];
}

-(void)setAshTrackingRoute:(NSString *)AshTrackingRoute {
    NSString *route = [NSString stringWithFormat:@"%@/%@",
                       AshTrackingRoute,
                       [self.topViewController AshTrackingRename]];
    [self.topViewController setAshTrackingRoute:route];
}

-(void)setAshTrackingLastActivity:(NSString *)AshTrackingLastActivity {
    
}

@end
