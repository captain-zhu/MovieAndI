//
//  ZYXSimilarMoviesCollectionViewCell.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXSimilarMoviesCollectionViewCell.h"

static CGFloat const kImageViewCornerRadius = 2.0;
@implementation ZYXSimilarMoviesCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.posterImageView.layer.cornerRadius = kImageViewCornerRadius;
    self.posterImageView.layer.masksToBounds = YES;
    
    self.cellBackgroundView.layer.cornerRadius = self.posterImageView.layer.cornerRadius;
    self.cellBackgroundView.layer.masksToBounds = YES;
    self.cellBackgroundView.layer.borderColor =  [UIColor colorWithRed:180/255.0 green:180/225.0 blue:180/255.0 alpha:1.0].CGColor;
    self.cellBackgroundView.layer.borderWidth = 1.0f;
}

@end
