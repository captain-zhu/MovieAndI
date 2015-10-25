//
//  SearchResultTableViewCell.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/16.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXSearchResultTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ZYXSearchResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.posterImageView sd_cancelCurrentImageLoad];
}

@end
