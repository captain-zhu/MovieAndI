//
//  ZYXMenuButton.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/14.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYXMenuButton : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) void (^tapHandler)();

@end
