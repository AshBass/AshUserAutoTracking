//
//  UIResponder+AshUserAutoTracking.h
//  Pods
//
//  Created by Harry Houdini on 2020/1/7.
//

#import <UIKit/UIKit.h>

@interface UIResponder (AshUserAutoTracking)

//@property (nonatomic, copy) NSString *AshTrackingRoute;
//@property (nonatomic, copy) NSString *AshTrackingRename;

-(void)setAshTrackingRoute:(NSString *)AshTrackingRoute;

-(NSString *)AshTrackingRoute;

-(void)setAshTrackingRename:(NSString *)AshTrackingRename;

-(NSString *)AshTrackingRename;

@end
