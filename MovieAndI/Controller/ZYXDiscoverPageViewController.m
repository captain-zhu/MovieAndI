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

@interface ZYXDiscoverPageViewController ()<UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *pages;

@end

@implementation ZYXDiscoverPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pages = [ZYXPages allPages];
    ZYXMovieListViewController *movieListViewController = (ZYXMovieListViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieList" class:[ZYXMovieListViewController class]];
    movieListViewController.page = self.pages[0];
    
    [self setViewControllers:@[movieListViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.dataSource = self;
    NSLog(@"page view did load");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    ZYXMovieListViewController *oldViewController = (ZYXMovieListViewController *)viewController;
    int newIndex = oldViewController.page.index + 1;
    if (newIndex > ([self.pages count] - 1)) {
        return  nil;
    }
    
    ZYXMovieListViewController *movieListViewController = (ZYXMovieListViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieList" class:[ZYXMovieListViewController class]];
    movieListViewController.page = self.pages[newIndex];
    
    return movieListViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    ZYXMovieListViewController *oldViewController = (ZYXMovieListViewController *)viewController;
    int newIndex = oldViewController.page.index - 1;
    if (newIndex < 0) {
        return  nil;
    }
    
    ZYXMovieListViewController *movieListViewController = (ZYXMovieListViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieList" class:[ZYXMovieListViewController class]];
    movieListViewController.page = self.pages[newIndex];
    
    return movieListViewController;
}
































@end
