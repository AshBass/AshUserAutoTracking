//
//  BaseViewController.m
//  Example
//
//  Created by Harry Houdini on 2020/1/10.
//  Copyright © 2020 CrimsonHo. All rights reserved.
//

#import "BaseViewController.h"
#import <UIResponder+AshUserAutoTracking.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@",[self AshTrackingRoute]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    self.centerLabel = label;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
