//
//  ZYXMovieCollectionViewCell.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Movie.h"

@interface ZYXMovieCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backdropImageView;
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *selfScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *topScoreLabel;
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

- (void)updateParallaxOffset:(CGRect )bounds;

@end
