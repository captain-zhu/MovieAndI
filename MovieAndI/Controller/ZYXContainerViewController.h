//
//  ZYXContainerViewController.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/14.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ZYXContainerViewController : UIViewController

@property (nonatomic, strong) UIViewController *centerViewController;

- (instancetype)initWithSideMenuController:(UIViewController *)menuController;
- (void)changeCenterController;
- (void)toggleSideMenu;

@end
