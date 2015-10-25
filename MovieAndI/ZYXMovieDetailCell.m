//
//  ZYXMovieDetailCell.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieDetailCell.h"

@implementation ZYXMovieDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.posterImageView.layer.cornerRadius = self.posterImageView.frame.size.width / 2;
    self.posterImageView.layer.masksToBounds = YES;
    
    self.watchTrailersButton.layer.borderColor = [UIColor colorWithRed:0/255.0 green:161/225.0 blue:0/255.0 alpha:1.0].CGColor;
    self.watchTrailersButton.layer.cornerRadius = 15.0f;
    
    self.watchPhotosButton.layer.borderColor =  self.watchPhotosButton.titleLabel.textColor.CGColor;
    self.watchPhotosButton.layer.borderWidth = 1.0f;
    self.watchPhotosButton.layer.cornerRadius = 15.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
