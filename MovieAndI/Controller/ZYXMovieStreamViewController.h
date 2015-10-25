//
//  ZYXMovieStreamViewController.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXMyPages.h"
#import "Movie.h"
#import "ZYXMenuButton.h"

@interface ZYXMovieStreamViewController : UIViewController

@property (nonatomic, strong) ZYXMyPages *page;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) ZYXMenuButton *menuButton;

@end
