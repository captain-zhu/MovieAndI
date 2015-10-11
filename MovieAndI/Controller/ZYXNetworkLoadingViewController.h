//
//  ZYXNetworkLoadingViewController.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/10.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXActivityIndicator.h"

@protocol ZYXNetworkLoadingViewControllerDelegate <NSObject>

-(void)retryRequest;

@end

@interface ZYXNetworkLoadingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet ZYXActivityIndicator *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *noContentView;

@property (nonatomic, weak) id<ZYXNetworkLoadingViewControllerDelegate> delegate;

- (IBAction)tryRefresh:(UIButton *)sender;

- (void)showLoadingView;
- (void)showNoContentView;
- (void)showErrorView;

@end
