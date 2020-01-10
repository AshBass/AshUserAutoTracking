//
//  UIControl+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import "UIControl+AshUserAutoTracking.h"
#import "NSObject+AshUserAutoTracking.h"
#import "UIResponder+AshUserAutoTracking.h"
#import "UIViewController+AshUserAutoTracking.h"
#import <objc/runtime.h>

@implementation UIControl (AshUserAutoTracking)

+(void)load {
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(sendAction:to:forEvent:) exchangeSEL:@selector(AshUserAutoTracking_sendAction:to:forEvent:)];
}

-(void)AshUserAutoTracking_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    /*
     遍历寻找到 controller
     若是 cell 上的按钮，则把所在的 cell 的 indexPath 也记录下来
     */
    UIResponder *responder = self;
    UIViewController *viewController;
    UIView *tableViewOrCollectionView;
    UIView *cell;
    while (responder && ![responder isKindOfClass:[UIViewController class]]) {
        if ([responder isKindOfClass:[UITableView class]]||
            [responder isKindOfClass:[UICollectionView class]]) {
            tableViewOrCollectionView = (UIView*)responder;
        }else if ([responder isKindOfClass:[UITableViewCell class]] ||
                  [responder isKindOfClass:[UICollectionViewCell class]]) {
            cell = (UIView*)responder;
        }
        responder = [responder nextResponder];
    }
    viewController = (UIViewController*)responder;
    if (!viewController) {
        /// window 上的按钮点击
        [self AshUserAutoTracking_sendAction:action to:target forEvent:event];
        return;
    }
    NSString *route;
    if (!cell) {
        /// .button(eventType[0],selector:foo)
        route = [NSString stringWithFormat:@".%@(eventType[%ld],selector:%@)",
                           [self AshTrackingRename],
                           event.type,
                           NSStringFromSelector(action)];
    }else {
        NSIndexPath *path;
        if ([tableViewOrCollectionView isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView*)tableViewOrCollectionView;
            UITableViewCell *tableViewCell = (UITableViewCell*)cell;
            path = [tableView indexPathForCell:tableViewCell];
            
        }else if ([tableViewOrCollectionView isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView*)tableViewOrCollectionView;
            UICollectionViewCell *collectionViewCell = (UICollectionViewCell*)cell;
            path = [collectionView indexPathForCell:collectionViewCell];
        }
        /// .tableview[0,0].cell[0].button(eventType[0],selector:foo)
        route = [NSString stringWithFormat:@".%@[%ld,%ld].%@.%@(eventType[%ld],selector:%@)",
                 [tableViewOrCollectionView AshTrackingRename],
                 path.section,
                 path.row,
                 [cell AshTrackingRename],
                 [self AshTrackingRename],
                 event.type,
                 NSStringFromSelector(action)];
    }
    [viewController setAshTrackingLastActivity:route];
    [self AshUserAutoTracking_sendAction:action to:target forEvent:event];
}


@end
