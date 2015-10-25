//
//  SearchResultTableViewCell.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/16.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface ZYXSearchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;

@end
