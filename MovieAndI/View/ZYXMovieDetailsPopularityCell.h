//
//  ZYXMovieDetailsPopularityCell.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXRatingCircle.h"

@interface ZYXMovieDetailsPopularityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *popularityLabel;
@property (weak, nonatomic) IBOutlet ZYXRatingCircle *ratingCircle;

@end
