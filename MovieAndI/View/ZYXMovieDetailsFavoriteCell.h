//
//  ZYXMovieDetailsFavoriteCell.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface ZYXMovieDetailsFavoriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *tenLabel;
@property (weak, nonatomic) IBOutlet UIButton *watchListButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end
