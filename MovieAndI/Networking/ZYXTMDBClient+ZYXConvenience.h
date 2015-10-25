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
#import "MovieDetails.h"
#import "MovieReviews.h"
//#import "MovieStatus.h"
#import "ZYXMovieStatus.h"

@interface ZYXTMDBClient (ZYXConvenience)

- (void)authenticateWithViewController:(UIViewController *)hostViewController
                     completionHandler:(void(^)(BOOL success, NSString *errerString))completionHandler;

- (void)getFavoriteMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getRatedMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getWatchlistMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;

- (void)getPopularMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getNowplayingMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getUpcomingMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getTopRatedMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (NSURLSessionDataTask *)getMoviesForSearchString:(NSString*)searchString WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getMovieDetailsWithID:(NSString *)id WithCompletionHandler:(void(^)(MovieDetails *movieDetails, NSError *error))completionHandler;
- (void)getSimilarMoviesWithID:(NSString *)id WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
- (void)getMovieReviewsWithID:(NSString *)id WithCompletionHandler:(void(^)(MovieReviews *movieReviews, NSError *error))completionHandler;
- (void)getMovieStatusWithID:(NSString *)id WithCompletionHandler:(void(^)(ZYXMovieStatus *movieStatus, NSError *error))completionHandler;

- (void)postRatingValue:(NSString *)value forMovieWithID:(NSString *)id withCompletionHandler:(void(^)(BOOL succuss))completionHandler;
- (void)postWatchlist:(BOOL)watchlist forMovieWithID:(NSString *)id withCompletionHandler:(void(^)(BOOL succuss))completionHandler;
- (void)postFavorite:(BOOL)favorite forMovieWithID:(NSString *)id withCompletionHandler:(void(^)(BOOL succuss))completionHandler;

@end
