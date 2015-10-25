//
//  ZYXCommentsCell.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYXCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end
