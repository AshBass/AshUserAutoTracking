//
//  AshUserAutoTrackingDelegate.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import "AshUserAutoTrackingDelegate.h"
#import "UIResponder+AshUserAutoTracking.h"
#import "UIViewController+AshUserAutoTracking.h"
#import <objc/runtime.h>

@implementation AshUserAutoTrackingDelegate

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSString *preViewControllerRoute = [tabBarController AshTrackingRoute];
    NSString *nowViewControllerRename = [viewController AshTrackingRename];
    NSString *route = [NSString stringWithFormat:@"%@[%lu].%@",preViewControllerRoute,tabBarController.selectedIndex,nowViewControllerRename];
    [viewController setAshTrackingRoute:route];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self trackingInView:tableView indexPath:indexPath];
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self trackingInView:collectionView indexPath:indexPath];
    [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

-(void)trackingInView:(UIView*)view indexPath:(NSIndexPath*)indexPath {
    UIViewController *viewController;
    UIResponder *responder = [view nextResponder];
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
    }
    viewController = (UIViewController *)responder;
    /// .tableView[0,0]
    /// .collectionView[0,0]
    NSString *route = [NSString stringWithFormat:@".%@[%ld,%ld]",
                       [view AshTrackingRename],
                       indexPath.section,
                       indexPath.row
                       ];
    [viewController setAshTrackingLastActivity:route];
}

-(BOOL)respondsToSelector:(SEL)aSelector {
    return [self.delegate respondsToSelector:aSelector];
}

-(id)forwardingTargetForSelector:(SEL)aSelector {
    return self.delegate;
}

@end
