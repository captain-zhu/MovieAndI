//
//  ZYXTMDBClient+ZYXConvenience.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXTMDBClient.h"
#import <UIKit/UIKit.h>
#import "List.h"

@interface ZYXTMDBClient (ZYXConvenience)

- (void)authenticateWithViewController:(UIViewController *)hostViewController
                     completionHandler:(void(^)(BOOL success, NSString *errerString))completionHandler;

- (void)getFavoriteMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;

- (void)getPopularMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getNowplayingMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getUpcomingMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getTopRatedMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;

@end
