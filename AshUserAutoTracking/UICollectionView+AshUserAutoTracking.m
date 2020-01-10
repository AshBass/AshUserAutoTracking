//
//  UICollectionView+AshUserAutoTracking.m
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import "UICollectionView+AshUserAutoTracking.h"
#import "NSObject+AshUserAutoTracking.h"
#import "UIResponder+AshUserAutoTracking.h"
#import "AshUserAutoTrackingDelegate.h"
#import <objc/runtime.h>

@implementation UICollectionView (AshUserAutoTracking)

+(void)load {
    [self AshUserAutoTracking_exchangeInstanceMethod:self originalSEL:@selector(setDelegate:) exchangeSEL:@selector(AshUserAutoTracking_setDelegate:)];
}
-(void)AshUserAutoTracking_setDelegate:(id<UICollectionViewDelegate>)delegate {
    if ([delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        AshUserAutoTrackingDelegate *trackingDelegate = [[AshUserAutoTrackingDelegate alloc] init];
        trackingDelegate.delegate = delegate;
    }
    [self AshUserAutoTracking_setDelegate:delegate];
}

@end
