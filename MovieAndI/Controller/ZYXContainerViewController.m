//
//  ZYXContainerViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/14.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXContainerViewController.h"
#import "SideMenuViewController.h"
#import "MenuItems.h"
#import "ZYXMovieStreamViewController.h"
#import "ZYXMenuButton.h"

CGFloat const menuWidth = 80.0f;
CGFloat const animationTime = 0.5f;

@interface ZYXContainerViewController ()

@property (nonatomic, strong) UIViewController *menuViewController;

@end

@implementation ZYXContainerViewController{
    BOOL _isOpening;
}

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    _isOpening = NO;
    
    [self setup];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithSideMenuController:(UIViewController *)menuController
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.menuViewController = menuController;
        if ([self.menuViewController isKindOfClass:[SideMenuViewController class]]) {
            SideMenuViewController *controller = (SideMenuViewController *)menuController;
            controller.selectedIndex = 0;
            if (!controller.items || [controller.items count] == 0) {
                controller.items = [MenuItems sharedMenuItems];
                controller.selectedItem = controller.items[0];
                self.centerViewController = controller.selectedItem.controller;
            }
        }
    }
    return self;
}

#pragma mark -
#pragma mark UI Setup

- (void)setup
{
    [self addChildViewController:self.centerViewController];
    [self.view addSubview:self.centerViewController.view];
    [self.centerViewController didMoveToParentViewController:self];
    
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
    [self.menuViewController didMoveToParentViewController:self];
    
    self.menuViewController.view.layer.anchorPoint = CGPointMake(1.0, 0.5);
    self.menuViewController.view.frame = CGRectMake(-menuWidth, 0, menuWidth, CGRectGetHeight(self.view.frame));
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:panGesture];
    
    [self setToPercent:0];
}

#pragma mark -
#pragma mark Gesture

- (void)handleGesture:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:recognizer.view.superview];
    CGFloat progress = translation.x / menuWidth * (_isOpening ? 1.0 : -1.0);
    progress = MIN(MAX(progress, 0.0), 1.0);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            CGFloat isOpen = floor(self.centerViewController.view.frame.origin.x / menuWidth);
            _isOpening = ((isOpen == 1.0)? NO : YES);
            self.menuViewController.view.layer.shouldRasterize = YES;
            self.menuViewController.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
            break;
        }
        case UIGestureRecognizerStateChanged:{
            [self setToPercent:(_isOpening ? progress : (1 - progress))];
            break;
        }
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        case UIGestureRecognizerStateFailed:{
            self.menuViewController.view.layer.shouldRasterize = NO;
            CGFloat targetProgress;
            if (_isOpening) {
                targetProgress = (progress < 0.5) ? 0.0 : 1.0;
            } else {
                targetProgress = (progress < 0.5) ? 1.0 : 0.0;
            }
            
            [UIView animateWithDuration:animationTime animations:^{
                [self setToPercent:targetProgress];
            } completion:^(BOOL finished) {
                
            }];
            break;
        }
        default:
            break;
    }
}

- (void)changeCenterController
{
    UIViewController *oldViewController = self.centerViewController;
    
    SideMenuViewController *menuViewController = (SideMenuViewController *)self.menuViewController;
    
    [oldViewController willMoveToParentViewController:nil];
    [oldViewController.view removeFromSuperview];
    [oldViewController removeFromParentViewController];
    
    UIViewController *destinationViewController = menuViewController.selectedItem.controller;
    destinationViewController.view.frame = CGRectMake(menuWidth, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self addChildViewController:destinationViewController];
    [self.view addSubview:destinationViewController.view];
    [destinationViewController willMoveToParentViewController:self];
    self.centerViewController = destinationViewController;
}

- (void)toggleSideMenu
{
    CGFloat isOpen = floor(self.centerViewController.view.frame.origin.x / menuWidth);
    CGFloat targetProgress = ((isOpen == 1.0)? 0.0 : 1.0);
    
    [UIView animateWithDuration:animationTime animations:^{
        [self setToPercent:targetProgress];
    } completion:^(BOOL finished) {
        self.menuViewController.view.layer.shouldRasterize = NO;
    }];
}

- (void)setToPercent:(CGFloat)progress
{
    self.centerViewController.view.frame = CGRectMake(menuWidth * progress, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    self.menuViewController.view.layer.transform = [self menuTransformToPercent:progress];
    self.menuViewController.view.alpha = MAX(0.2, progress);
    
    ZYXMenuButton *menuButton;
    if ([self.centerViewController isKindOfClass:[ZYXMovieStreamViewController class]]) {
        ZYXMovieStreamViewController *streamViewController = (ZYXMovieStreamViewController *)self.centerViewController;
        menuButton = streamViewController.menuButton;
        if (menuButton) {
            CATransform3D identity = CATransform3DIdentity;
            identity.m34 = -1.0/1000;
            menuButton.imageView.layer.transform = CATransform3DRotate(identity, progress * M_PI, 1.0, 1.0, 0.0);
        }
    }
    
}

- (CATransform3D)menuTransformToPercent:(CGFloat)percent
{
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000;
    
    CGFloat angle = (1 - percent) * -M_PI_2;
    
    CATransform3D rotationTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    CATransform3D transitonTransform = CATransform3DMakeTranslation(menuWidth * percent, 0, 0);
    
    return CATransform3DConcat(rotationTransform, transitonTransform);
}




@end
