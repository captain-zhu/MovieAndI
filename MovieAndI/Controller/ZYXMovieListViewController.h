//
//  ZYXMovieListViewController.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/7.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXDiscoverPages.h"
#import "ZYXNetworkLoadingViewController.h"

@interface ZYXMovieListViewController : UIViewController

@property (nonatomic, strong) ZYXDiscoverPages *page;
@property (nonatomic, strong) NSArray *movies;

@property (nonatomic, weak) IBOutlet UIView *networkingLoadingContainerView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) ZYXNetworkLoadingViewController *networkingLoadingViewController;

@end
