//
//  SecondViewController.m
//  Example
//
//  Created by Harry Houdini on 2020/1/8.
//  Copyright © 2020 CrimsonHo. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "ButtonTableViewCell.h"
#import "PushViewController.h"
#import "PresentViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray *action;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:NSSelectorFromString(self.action[indexPath.row])];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ButtonTableViewCell class])];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    [cell.button addTarget:self action:NSSelectorFromString(self.action[indexPath.row]) forControlEvents:(UIControlEventTouchUpInside)];
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

-(NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"push",@"present"];
    }
    return _dataSource;
}

-(NSArray *)action {
    if (!_action) {
        _action = @[NSStringFromSelector(@selector(push)),NSStringFromSelector(@selector(present))];
    }
    return _action;
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
