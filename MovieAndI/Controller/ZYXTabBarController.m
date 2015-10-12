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

@interface ZYXTabBarController ()

@end

@implementation ZYXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
//    ZYXMovieListNavigationController *pageViewNavigationController = (ZYXMovieListNavigationController *)[StoryBoardUtilities viewControllerForStoryboardName:@"DiscoverPage" class:[ZYXMovieListNavigationController class]];
    ZYXDiscoverPageViewController *pageViewController = (ZYXDiscoverPageViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"DiscoverPage" class:[ZYXDiscoverPageViewController class]];
    self.viewControllers = @[pageViewController];
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
