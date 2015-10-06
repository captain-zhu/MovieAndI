//
//  ZYXAuthViewController.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYXAuthViewController : UIViewController

@property (nonatomic, strong) NSURLRequest *urlRequest;
@property (nonatomic, strong) NSString *requestToken;
@property (nonatomic, strong) void (^completionHandler)(BOOL success, NSString *errorString);

@end
