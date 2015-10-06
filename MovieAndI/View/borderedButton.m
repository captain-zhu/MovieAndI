//
//  borderedButton.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "borderedButton.h"

@implementation borderedButton

#pragma mark - Construct

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

#pragma mark - Setters

- (void)setBackingColor:(UIColor *)backingColor
{
    if (_backingColor != nil) {
        _backingColor = backingColor;
        self.backgroundColor = backingColor;
    }
}

- (void)setHighlightedBackingColor:(UIColor *)highlightedBackingColor
{
    if (_highlightedBackingColor != nil) {
        _highlightedBackingColor = highlightedBackingColor;
        _backingColor = highlightedBackingColor;
    }
}

#pragma mark - Tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.backgroundColor = self.highlightedBackingColor;
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    self.backgroundColor = self.backingColor;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    self.backgroundColor = self.backingColor;
}

#pragma mark - Layout

- (CGSize)sizeThatFits:(CGSize)size
{
    const CGFloat extraButtonPadding  = 14.0;
    CGSize sizeThatFit = CGSizeZero;
    sizeThatFit.width = [super sizeThatFits:size].width + extraButtonPadding;
    sizeThatFit.height = 44.0;
    return sizeThatFit;
}

@end
