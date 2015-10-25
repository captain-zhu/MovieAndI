//
//  ZYXMenuButton.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/14.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMenuButton.h"

@implementation ZYXMenuButton

- (void)didMoveToSuperview
{
    self.frame = CGRectMake(0, 0, 20, 20);
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu"]];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)]];
    [self addSubview:self.imageView];
}

- (void)didTap
{
    if (self.tapHandler) {
        self.tapHandler();
    }
}

@end
