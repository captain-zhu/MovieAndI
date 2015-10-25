//
//  ZYXTabBarController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXTabBarController.h"
#import "ZYXDiscoverPageViewController.h"
#import "StoryBoardUtilities.h"
#import "ZYXContainerViewController.h"
#import "SideMenuViewController.h"
#import "ZYXSearchResultTableViewController.h"

@interface ZYXTabBarController ()

@end

@implementation ZYXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    ZYXMovieListNavigationController *pageViewNavigationController = (ZYXMovieListNavigationController *)[StoryBoardUtilities viewControllerForStoryboardName:@"DiscoverPage" class:[ZYXMovieListNavigationController class]];
    ZYXDiscoverPageViewController *pageViewController = (ZYXDiscoverPageViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"DiscoverPage" class:[ZYXDiscoverPageViewController class]];
    SideMenuViewController *sideMenuViewController = (SideMenuViewController*)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieCollection" class:[SideMenuViewController class]];
    ZYXContainerViewController *containerViewController = [[ZYXContainerViewController alloc] initWithSideMenuController:sideMenuViewController];
    ZYXSearchResultTableViewController *searchViewController = (ZYXSearchResultTableViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"SearchResult" class:[ZYXSearchResultTableViewController class]];
    self.viewControllers = @[pageViewController, containerViewController, searchViewController];
    UITabBarItem *itemOne = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"genre_120-Small"] tag:1008];
    UITabBarItem *itemTwo = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"MyList"] tag:1009];
    UITabBarItem *itemThree = [[UITabBarItem alloc] initWithTitle:@"搜索" image:[UIImage imageNamed:@"searchIcon"] tag:1100];
    pageViewController.tabBarItem = itemOne;
    containerViewController.tabBarItem = itemTwo;
    searchViewController.tabBarItem = itemThree;
    
    NSLog(@"tab bar viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
