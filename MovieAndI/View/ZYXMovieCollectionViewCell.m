//
//  ZYXMovieCollectionViewCell.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Color+Hex.h"

@interface ZYXMovieCollectionViewCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backdropImageViewCenterConstraint;
@property (nonatomic, assign) CGFloat parallaxOffset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *posterImageViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *topCoverView;
@property (weak, nonatomic) IBOutlet UIView *posterImageGradientView;

@end

@implementation ZYXMovieCollectionViewCell

- (instancetype)init
{
    if ((self = [super init])) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setParallaxOffset:(CGFloat)parallaxOffset
{
    self.backdropImageViewCenterConstraint.constant = parallaxOffset;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self.backdropImageView sd_cancelCurrentImageLoad];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    CGFloat standardHeight = 100.0f;
    CGFloat featureHeight = 280.0f;
    
    CGFloat delta = 1 - ((CGFloat)(featureHeight - CGRectGetHeight(self.frame)) / (featureHeight - standardHeight));
    
    CGFloat miniAlpha = 0;
    CGFloat maxAlpha = 0.5;
    
    self.coverView.alpha = maxAlpha - (delta * (maxAlpha - miniAlpha));
    
    CGFloat scale = MAX(delta, 0.5);
    self.titelLabel.transform = CGAffineTransformMakeScale(scale, scale);
    
    self.originalTitleLabel.alpha = delta;
    self.selfScoreLabel.alpha = delta;
    self.topScoreLabel.alpha = delta;
    self.posterImageView.alpha = delta;
    self.starRating.alpha = delta;
    self.releseDateLabel.alpha =  delta;
    if (delta > 0.95) {
        self.topCoverView.alpha = delta;
    } else {
        self.topCoverView.alpha = 0;
    }
    
    CGFloat posterImageDistance = 140.0f;
    CGFloat moveDistance = posterImageDistance * delta;
    self.posterImageViewTopConstraint.constant = -145 + moveDistance;
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHexString:@"#c8c8c8ff"] CGColor], (id)[[UIColor colorFromHexString:@"#aaaaaaff"] CGColor], nil];
    [self.posterImageGradientView.layer insertSublayer:layer atIndex:0];
    
}


- (void)updateParallaxOffset:(CGRect )bounds
{
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGPoint offsetFromCenter = CGPointMake(center.x - self.center.x, center.y - self.center.y);
    CGFloat maxVerticalOffset = (CGRectGetHeight(bounds)/2) + (CGRectGetHeight(self.bounds));
    CGFloat scaleFactor = 40 / maxVerticalOffset;
    self.parallaxOffset = -offsetFromCenter.y * scaleFactor;
}
















@end
