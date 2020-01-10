//
//  FirstViewController.m
//  Example
//
//  Created by Harry Houdini on 2020/1/8.
//  Copyright © 2020 CrimsonHo. All rights reserved.
//

#import "FirstViewController.h"
#import "ButtonTableViewCell.h"
#import "PushViewController.h"
#import "PresentViewController.h"
#import "ViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:NSSelectorFromString(self.dataSource[indexPath.row])];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ButtonTableViewCell class])];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    [cell.button addTarget:self action:NSSelectorFromString(self.dataSource[indexPath.row]) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(void)push {
    PushViewController *vc = [[PushViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)present {
    PresentViewController *vc = [[PresentViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

-(void)pushNavigationController {
    NSLog(@"Pushing a navigation controller is not supported");
//    ViewController *vc = [[ViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self.navigationController pushViewController:nav animated:YES];
}

-(void)presentNavigationController {
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)pushTabBarController {
    ViewController *vc1 = [[ViewController alloc] init];
    ViewController *vc2 = [[ViewController alloc] init];
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[vc1,vc2];
    [self.navigationController pushViewController:tab animated:YES];
}

-(void)presentTabBarController {
    ViewController *vc1 = [[ViewController alloc] init];
    ViewController *vc2 = [[ViewController alloc] init];
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[vc1,vc2];
    [self presentViewController:tab animated:YES completion:nil];
}

-(NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"push",@"present",@"pushNavigationController",@"presentNavigationController",@"pushTabBarController",@"presentTabBarController"];
    }
    return _dataSource;
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
