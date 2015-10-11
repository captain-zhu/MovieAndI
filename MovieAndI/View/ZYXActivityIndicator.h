//
//  ZYXActivityIndicator.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/10.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYXActivityIndicator : UIView

@property (nonatomic) BOOL hidesWhenStopped;
@property (nonatomic, strong) UIColor *color;

-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;

@end
