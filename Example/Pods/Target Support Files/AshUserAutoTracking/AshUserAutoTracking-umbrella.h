#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AshUserAutoTrackingDelegate.h"
#import "NSObject+AshUserAutoTracking.h"
#import "UICollectionView+AshUserAutoTracking.h"
#import "UIControl+AshUserAutoTracking.h"
#import "UINavigationController+AshUserAutoTracking.h"
#import "UIResponder+AshUserAutoTracking.h"
#import "UITabBarController+AshUserAutoTracking.h"
#import "UITableView+AshUserAutoTracking.h"
#import "UIViewController+AshUserAutoTracking.h"
#import "UIWindow+AshUserAutoTracking.h"

FOUNDATION_EXPORT double AshUserAutoTrackingVersionNumber;
FOUNDATION_EXPORT const unsigned char AshUserAutoTrackingVersionString[];

