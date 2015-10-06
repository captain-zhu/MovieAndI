//
//  ZYXAuthViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXAuthViewController.h"
#import "ZYXTMDBClient.h"

@interface ZYXAuthViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZYXAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.navigationItem.title = @"The Movie DB 认证";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAuth)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.urlRequest != nil) {
        [self.webView loadRequest:self.urlRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Cancel Auth

- (void)cancelAuth
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.webView.request.URL.absoluteString isEqualToString:[NSString stringWithFormat:@"%@%@/allow", kConstantsAuthorizationURL, self.requestToken]]) {
        [self dismissViewControllerAnimated:YES completion:^{
            self.completionHandler(YES, nil);
        }];
    }
}

@end
