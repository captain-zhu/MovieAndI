//
//  ZYXSignInViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXSignInViewController.h"
#import "borderedButton.h"
#import "StoryBoardUtilities.h"
#import "ZYXTabBarController.h"
#import "ZYXTMDBClient.h"

@interface ZYXSignInViewController ()


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet borderedButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *debugLabel;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ZYXSignInViewController

#pragma mark  - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.session = [NSURLSession sharedSession];

    //确定UI
    [self configureUI];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.debugLabel.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)loginButtonTouchUpInside:(borderedButton *)sender {
    [[ZYXTMDBClient sharedInstance] authenticateWithViewController:self completionHandler:^(BOOL success, NSString *errerString) {
        if (success) {
            [self completeLogin];
        } else {
            [self configureUI];
            [self displayError:errerString];
        }
    }];
}

#pragma mark - LoginViewController

- (void)completeLogin
{
    dispatch_async(dispatch_get_main_queue(),^{
        self.debugLabel.text = @"";
        ZYXTabBarController *tabBarController = (ZYXTabBarController *)[StoryBoardUtilities viewControllerForStoryboardName:@"TabBarController" class:[ZYXTabBarController class]];
        [self presentViewController:tabBarController animated:YES completion:nil];
    });
}

#pragma mark - Modify UI

- (void)displayError:(NSString *)errorString
{
    dispatch_async(dispatch_get_main_queue(),^{
        __weak NSString *weakErrorString = errorString;
        if (weakErrorString) {
            self.debugLabel.text = weakErrorString;
        }
    });
}


- (void)configureUI
{
    //将背景颜色渐进
    self.view.backgroundColor = [UIColor clearColor];
    UIColor *topColor = [UIColor colorWithRed:0.345
                                        green:0.839 blue:0.988 alpha:1.0].CGColor;
    UIColor *bottomColor = [UIColor colorWithRed:0.023
                                           green:0.569 blue:0.910 alpha:1.0].CGColor;
    CAGradientLayer *backgroundGradient = [[CAGradientLayer alloc] init];
    backgroundGradient.colors = @[topColor, bottomColor];
    backgroundGradient.locations = @[@0.0, @1.0];
    backgroundGradient.frame = self.view.frame;
    [self.view.layer insertSublayer:backgroundGradient atIndex:0];

    //确定标题的UI
    self.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:24];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    
    //确定debugLabel的UI
    self.debugLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:20];
    self.debugLabel.textColor = [UIColor whiteColor];
    
    // 确定login button
    self.loginButton.highlightedBackingColor = [UIColor colorWithRed:0.0
                                                               green:0.098 blue:0.686 alpha:1.0];
    self.loginButton.backingColor = [UIColor colorWithRed:0.0
                                                    green:0.502 blue:0.839 alpha:1.0];
    self.loginButton.backgroundColor = [UIColor colorWithRed:0.0
                                                       green:0.502 blue:0.839 alpha:1.0];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = 8.0;
    self.loginButton.layer.shadowRadius = 2;
    self.loginButton.layer.shadowOpacity = 0.5;
    self.loginButton.layer.shadowOffset = CGSizeZero;
//    self.loginButton.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.loginButton.bounds cornerRadius:8.0].CGPath;
    self.loginButton.layer.shadowColor = [UIColor blackColor].CGColor;

}

@end
