//
//  ZYXDiscoverPageViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/7.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXDiscoverPageViewController.h"
#import "ZYXMovieListViewController.h"
#import "StoryBoardUtilities.h"
#import "ZYXDiscoverPages.h"
#import "Color+Hex.h"

@interface ZYXDiscoverPageViewController ()<CAPSPageMenuDelegate>

@property (nonatomic, strong) NSArray *pages;


@end

@implementation ZYXDiscoverPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pages = [ZYXDiscoverPages allPages];
    
    NSMutableArray *controllerArray = [NSMutableArray array];
    
    for (int i=0; i < [self.pages count]; i++) {
        ZYXMovieListViewController *movieListViewController = (ZYXMovieListViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieList" class:[ZYXMovieListViewController class]];
        movieListViewController.page = self.pages[i];
        movieListViewController.title = movieListViewController.page.title;
        [controllerArray addObject:movieListViewController];
    }
    
    NSDictionary *parameters = @{CAPSPageMenuOptionMenuItemSeparatorWidth: @(CGRectGetWidth(self.view.bounds)/[self.pages count]),
                                 CAPSPageMenuOptionSelectionIndicatorHeight:@(3),
                                 CAPSPageMenuOptionUseMenuLikeSegmentedControl: @(NO),
                                 CAPSPageMenuOptionViewBackgroundColor:[UIColor colorWithRed:255.0f/255 green:127.0f/255 blue:0.0f alpha:1],
                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor clearColor],                                CAPSPageMenuOptionSelectionIndicatorColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionMenuHeight:@(30),
                                 CAPSPageMenuOptionMenuMargin:@(0),
                                 CAPSPageMenuOptionMenuItemWidth:@(CGRectGetWidth(self.view.bounds)/[self.pages count]),
                                 };
    self.pagemenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 20.0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) options:parameters];
    NSLog(@"page view did load");
    [self.view addSubview:self.pagemenu.view];
    self.pagemenu.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark CAPSPageMenuDelegate

- (void)didMoveToPage:(UIViewController *)controller index:(NSInteger)index
{
    if ([controller isKindOfClass:[ZYXMovieListViewController class]]) {
        NSLog(@"It's movieList View Controller");
        ZYXMovieListViewController *movieListViewController = (ZYXMovieListViewController *)controller;
        if (!movieListViewController.movies) {
            [movieListViewController.networkingLoadingViewController showLoadingView];
        }
    }
}






























@end
