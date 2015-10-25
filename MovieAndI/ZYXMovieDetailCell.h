//
//  ZYXMovieDetailCell.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYXMovieDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *generesLabel;
@property (weak, nonatomic) IBOutlet UIButton *watchPhotosButton;
@property (weak, nonatomic) IBOutlet UIButton *watchTrailersButton;

@end
