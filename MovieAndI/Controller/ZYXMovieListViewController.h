//
//  ZYXMovieListViewController.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/7.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXPages.h"
#import "ZYXNetworkLoadingViewController.h"

@interface ZYXMovieListViewController : UIViewController

@property (nonatomic, strong) ZYXPages *page;
@property (nonatomic, strong) List *list;

@property (nonatomic, weak) IBOutlet UIView *networkingLoadingContainerView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
