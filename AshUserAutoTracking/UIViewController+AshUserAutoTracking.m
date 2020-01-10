//
//  UIViewController+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import "UIViewController+AshUserAutoTracking.h"
#import "NSObject+AshUserAutoTracking.h"
#import "UIResponder+AshUserAutoTracking.h"
#import <objc/runtime.h>

@implementation UIViewController (AshUserAutoTracking)

+(void)load {
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(init) exchangeSEL:@selector(AshUserAutoTracking_init)];
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(initWithCoder:) exchangeSEL:@selector(AshUserAutoTracking_initWithCoder:)];
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(presentViewController:animated:completion:) exchangeSEL:@selector(AshUserAutoTracking_presentViewController:animated:completion:)];
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(addChildViewController:) exchangeSEL:@selector(AshUserAutoTracking_addChildViewController:)];
}

-(instancetype)AshUserAutoTracking_init {
    [self setAshTrackingRoute:[self AshTrackingRename]];
    [self setAshTrackingRename:NSStringFromClass([self class])];
    [self setAshTrackingLastActivity:nil];
    return [self AshUserAutoTracking_init];
}

-(instancetype)AshUserAutoTracking_initWithCoder:(NSCoder *)coder {
    [self setAshTrackingRoute:[self AshTrackingRename]];
    [self setAshTrackingRename:NSStringFromClass([self class])];
    [self setAshTrackingLastActivity:nil];
    return [self AshUserAutoTracking_initWithCoder:coder];
}

-(void)AshUserAutoTracking_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    NSString *preViewControllerRoute = [NSString stringWithFormat:@"%@%@",
                                        [self AshTrackingRoute],
                                        [self AshTrackingLastActivity]];
    NSString *nowViewControllerRename = [viewControllerToPresent AshTrackingRename];
    NSString *route = [NSString stringWithFormat:@"%@/%@",preViewControllerRoute,nowViewControllerRename];
    
    [self setAshTrackingLastActivity:nil];
    [viewControllerToPresent setAshTrackingRoute:route];
    
    [self AshUserAutoTracking_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)AshUserAutoTracking_addChildViewController:(UIViewController *)childController {
    /// UITabBarController 会触发
    /// UINavigationController 不会触发
    /// controller/controller[0].ViewController
    NSString *nowViewControllerRename = [childController AshTrackingRename];
    NSString *route = [NSString stringWithFormat:@"[%lu].%@",
             self.childViewControllers.count,
             nowViewControllerRename];

    [childController setAshTrackingRoute:route];
    [self AshUserAutoTracking_addChildViewController:childController];
}

-(void)setAshTrackingLastActivity:(NSString *)AshTrackingLastActivity {
    if (!AshTrackingLastActivity) {
        AshTrackingLastActivity = @"";
    }
    objc_setAssociatedObject(self, "AshTrackingLastActivity", [AshTrackingLastActivity copy], OBJC_ASSOCIATION_COPY);
}

-(NSString*)AshTrackingLastActivity {
    NSString *lastActivity = objc_getAssociatedObject(self, "AshTrackingLastActivity");
    return lastActivity ? lastActivity : @"";
}

@end
