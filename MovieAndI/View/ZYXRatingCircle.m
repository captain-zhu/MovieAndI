//
//  ZYXRatingCircle.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/19.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXRatingCircle.h"

@interface ZYXRatingCircle ()

@property (nonatomic, strong) CAShapeLayer *bgLayer;
@property (nonatomic, strong) CAShapeLayer *fgLayer;
@property (nonatomic, strong) UILabel *ratingLabel;

@end

@implementation ZYXRatingCircle

#pragma mark -
#pragma mark Lazy Var

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    [self configure];
}

- (void)setFgColor:(UIColor *)fgColor
{
    _fgColor = fgColor;
    [self configure];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self configure];
}

- (void)setMaxValue:(int)maxValue
{
    _maxValue = maxValue;
    [self animate];
}

- (void)setCurrentValue:(double)currentValue
{
    _currentValue = currentValue;
    [self animate];
}

#pragma mark -
#pragma mark Override Methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    [self configure];
}

- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self setup];
    [self configure];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupShapeLayer:self.bgLayer];
    [self setupShapeLayer:self.fgLayer];
}

#pragma mark -
#pragma mark Help Methods

- (void)setup
{
    // setup bg
    if (!self.bgLayer) {
        self.bgLayer = [[CAShapeLayer alloc] init];
    }
    self.bgLayer.lineWidth = 10;
    self.bgLayer.fillColor = [UIColor clearColor].CGColor;
    self.bgLayer.strokeEnd = 1;
    [self.layer addSublayer:self.bgLayer];
    
    //setup fg
    if (!self.fgLayer) {
        self.fgLayer = [[CAShapeLayer alloc] init];
    }
    self.fgLayer.lineWidth = 10;
    self.fgLayer.fillColor = [UIColor clearColor].CGColor;
    self.fgLayer.strokeEnd = 0;
    [self.layer addSublayer:self.fgLayer];
    
    //setup rating label
    if (!self.ratingLabel) {
        self.ratingLabel = [[UILabel alloc] init];
    }
    self.ratingLabel.font = [UIFont fontWithName:@"Avenir Next" size:13];
    self.ratingLabel.textColor = [UIColor whiteColor];
    self.ratingLabel.text = @"0/0";
    self.ratingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.ratingLabel];
    
    // setup constraints
    NSLayoutConstraint *ratingLabelCenterX = [NSLayoutConstraint constraintWithItem:self.ratingLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint *ratingLabelCenterY = [NSLayoutConstraint constraintWithItem:self.ratingLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [NSLayoutConstraint activateConstraints:@[ratingLabelCenterX, ratingLabelCenterY]];
    
}

- (void)configure
{
    self.bgLayer.strokeColor = self.bgColor.CGColor;
    self.fgLayer.strokeColor = self.fgColor.CGColor;
    self.ratingLabel.textColor = self.textColor;
}

- (void)setupShapeLayer:(CAShapeLayer *)shapeLayer
{
    shapeLayer.frame = self.bounds;
    
    CGPoint center = self.ratingLabel.center;
    CGFloat radius = CGRectGetWidth(self.bounds) * 0.35;
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = M_PI + M_PI_2;
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    shapeLayer.path = path.CGPath;
}

- (void)animate
{
    self.ratingLabel.text = [NSString stringWithFormat:@"%0.1f/%d", self.currentValue, self.maxValue];
    
    CGFloat toValue = (CGFloat)self.currentValue / self.maxValue;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = 0;
    animation.toValue = [NSNumber numberWithFloat:toValue];
    animation.duration = toValue * 4;
    
    [self.fgLayer removeAnimationForKey:@"stroke"];
    [self.fgLayer addAnimation:animation forKey:@"stroke"];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.fgLayer.strokeEnd = toValue;
    [CATransaction commit];

}
































@end
