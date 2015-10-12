//
//  ZYXMovieDetailRefreshItem.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/12.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieDetailRefreshItem.h"

@implementation ZYXMovieDetailRefreshItem{
    CGPoint _centerStart;
    CGPoint _centerEnd;
}

- (instancetype)initWithView:(UIView *)view withCenterEnd:(CGPoint)centerEnd withParallaxRatio:(CGFloat)parallaxRatio withSceneHeight:(CGFloat)sceneHeight
{
    self = [super init];
    if (self) {
        self.view = view;
        _centerEnd = centerEnd;
        _centerStart = CGPointMake(centerEnd.x, centerEnd.y + (parallaxRatio * sceneHeight));
        self.view.center = _centerStart;
    }
    return self;
}

- (void)updateViewPositionForPercentage:(CGFloat)percentage
{
    self.view.center = CGPointMake(_centerStart.x + (_centerEnd.x - _centerStart.x)* percentage, _centerStart.y + (_centerEnd.y - _centerStart.y)*percentage);
}

@end
