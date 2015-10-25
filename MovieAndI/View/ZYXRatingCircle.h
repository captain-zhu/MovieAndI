//
//  ZYXRatingCircle.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/19.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZYXRatingCircle : UIView

@property (nonatomic, strong) IBInspectable UIColor *bgColor;
@property (nonatomic, strong) IBInspectable UIColor *fgColor;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic) IBInspectable int maxValue;
@property (nonatomic) IBInspectable double currentValue;

- (void)animate;

@end
