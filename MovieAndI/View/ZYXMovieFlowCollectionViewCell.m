//
//  ZYXMovieFlowCollectionViewCell.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieFlowCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ZYXMovieFlowCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.posterImageView sd_cancelCurrentImageLoad];
}

@end
