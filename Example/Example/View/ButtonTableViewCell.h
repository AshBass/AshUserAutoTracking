//
//  ButtonTableViewCell.h
//  Example
//
//  Created by Harry Houdini on 2020/1/8.
//  Copyright © 2020 CrimsonHo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
