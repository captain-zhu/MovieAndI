//
//  ZYXNetworkLoadingViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/10.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXNetworkLoadingViewController.h"

@interface ZYXNetworkLoadingViewController ()

@end

@implementation ZYXNetworkLoadingViewController

#pragma -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLoadingView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.activityIndicatorView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showLoadingView
{
    self.errorView.hidden = YES;
    
    self.activityIndicatorView.color = [UIColor colorWithRed:232.0/255.0f green:35.0/255.0f blue:111.0/255.0f alpha:1.0];
}

- (void)showErrorView
{
    self.noContentView.hidden = YES;
    self.errorView.hidden = NO;
}

- (void)showNoContentView
{
    self.noContentView.hidden = NO;
    self.errorView.hidden = YES;
}

#pragma mark - 
#pragma mark Action Methods

- (IBAction)tryRefresh:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(retryRequest)]) {
        [self.delegate retryRequest];
    }
    [self showLoadingView];
}

@end
