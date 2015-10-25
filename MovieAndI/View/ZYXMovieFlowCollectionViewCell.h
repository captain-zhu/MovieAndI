//
//  ZYXMovieFlowCollectionViewCell.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXRatingCircle.h"

@interface ZYXMovieFlowCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *anotherTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *releseDateLabel;
@property (weak, nonatomic) IBOutlet ZYXRatingCircle *ratingCircle;

@end
