//
//  ZYXTMDBClient+ZYXConvenience.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXTMDBClient.h"

@interface ZYXTMDBClient (ZYXConvenience)

- (void)authenticateWithViewController:(UIViewController *)hostViewController
                     completionHandler:(void(^)(BOOL success, NSString *errerString))completionHandler;

@end
