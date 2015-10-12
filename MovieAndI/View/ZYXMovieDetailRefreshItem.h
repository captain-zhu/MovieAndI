//
//  ZYXMovieDetailRefreshItem.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/12.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYXMovieDetailRefreshItem : NSObject

@property (nonatomic, weak) UIView *view;

- (instancetype)initWithView:(UIView *)view withCenterEnd:(CGPoint)centerEnd withParallaxRatio:(CGFloat)parallaxRatio withSceneHeight:(CGFloat)sceneHeight;
- (void)updateViewPositionForPercentage:(CGFloat)percentage;

@end
