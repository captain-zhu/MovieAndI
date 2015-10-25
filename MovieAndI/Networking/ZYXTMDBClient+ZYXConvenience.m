//
//  ZYXTMDBClient+ZYXConvenience.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//https://www.themoviedb.org/documentation/api/sessions

#import "ZYXTMDBClient+ZYXConvenience.h"
#import "ZYXAuthViewController.h"
#import "StoryBoardUtilities.h"
#import "User.h"

@implementation ZYXTMDBClient (ZYXConvenience)

#pragma mark - Authenticate methods
- (void)authenticateWithViewController:(UIViewController *)hostViewController
                     completionHandler:(void(^)(BOOL success, NSString *errerString))completionHandler
{
    [self getRequestTokenWithCompletionHandler:^(BOOL success, NSString *requestToken, NSString *errorString) {
        if (success) {
            [self loginWithToken:requestToken hostViewController:hostViewController completionHanlder:^(BOOL success, NSString *errorString) {
                if (success) {
                    [self getSessionwithToken:requestToken completionHandler:^(BOOL success, NSString *sessionID, NSString *errorString) {
                        if (success) {
                            self.client.sessionID = sessionID;
                            
                            [self getUserInfoWithSessionID:sessionID CompletionHandler:^(BOOL success, User *user, NSString *errorString) {
                                if (success) {
                                    self.client.user = user;
                                    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.client];
                                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"client"];
                                }
                                completionHandler(success, errorString);
                            }];
                        } else {
                            completionHandler(success, errorString);
                        }
                    }];
                } else {
                    completionHandler(success, errorString);
                }
            }];
        } else {
            completionHandler(success, errorString);
        }
    }];
}

//获得request token
- (void)getRequestTokenWithCompletionHandler:(void(^)(BOOL success, NSString *requestToken, NSString *errorString))completionHandler
{
    NSDictionary *parameters = [[NSDictionary alloc]init];
    
    [self taskForGetMethod:kMethodsAuthenticationTokenNew parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            completionHandler(NO, nil, @"Login Failed.(Request Token)");
        } else {
            [ZYXTMDBClient ObjectFromParseJSON:data WithCompletionHandler:^(id result, NSError *error) {
                if (error) {
                    completionHandler(NO, nil, @"Login Failed.(Request Token)");
                } else {
                    NSString *requestToken = (NSString *)(NSDictionary *)result[kJSONResponseKeysRequestToken];
                    if (requestToken) {
                        completionHandler(YES, requestToken, nil);
                    } else {
                        completionHandler(NO, nil, @"Login Failed.(Request Token)");
                    }
                }
            }];
        }
    }];
}

// 用token登录
- (void)loginWithToken:(NSString *)token hostViewController:(UIViewController *)hostViewController completionHanlder:(void(^)(BOOL success, NSString *errorString))completionHandler
{
    NSURL *authorizationURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kConstantsAuthorizationURL, token]];
    NSURLRequest *request = [NSURLRequest requestWithURL:authorizationURL];
    
    ZYXAuthViewController *authViewController = (ZYXAuthViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"SignIn" class:[ZYXAuthViewController class]];
    authViewController.urlRequest = request;
    authViewController.requestToken = token;
    authViewController.completionHandler = completionHandler;
    
    UINavigationController *authNavigationController = [[UINavigationController alloc] init];
    [authNavigationController pushViewController:authViewController animated:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [hostViewController presentViewController:authNavigationController animated:YES completion:nil];
    });
    
}

//获得sessionID
- (void)getSessionwithToken:(NSString *)token completionHandler:(void(^)(BOOL success, NSString *sessionID, NSString *errorString))completionHandler
{
    NSDictionary *parameters = @{kParameterKeysRequestToken : token};
    
    [self taskForGetMethod:kMethodsAuthenticationSessionNew parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            completionHandler(NO, nil, @"Login failed.(Session ID)");
        } else {
            [ZYXTMDBClient ObjectFromParseJSON:data WithCompletionHandler:^(id result, NSError *error) {
                if (error) {
                    completionHandler(NO, nil, @"Login failed.(Session ID)");
                } else {
                    NSString *session = (NSString *)(NSDictionary *)result[kJSONResponseKeysSessionID];
                    if (session) {
                        completionHandler(YES, session, nil);
                    } else {
                        completionHandler(NO, nil, @"Login failed.(Session ID)");
                    }
                }
            }];
        }
        
    }];
}

// 获得userID
- (void)getUserInfoWithSessionID:(NSString *)sessionID CompletionHandler:(void(^)(BOOL success,User *user, NSString *errorString))completionHandler
{
    NSDictionary *parameters = @{kParameterKeysSessionID : sessionID};
    
    [self taskForGetMethod:kMethodsAccount parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            completionHandler(NO, nil, @"Can't parse dictionary to USER");
        } else {
            [ZYXTMDBClient StringFromParseJSON:data WithCompletionHandler:^(NSString *result) {
                NSError *error = nil;
                User *user = [[User alloc] initWithString:result error:&error];
                completionHandler(YES, user, nil);
            }];
        }
    }];
}


#pragma mark - Get Convenience Methods

- (void)getFavoriteMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysSessionID: self.client.sessionID,
                                 kParameterKeysPage: pageString,
                                 kParameterKeysLauguage : @"zh",
                                 kURLKeysID: self.client.user.id};
    [self taskForGetMethod:kMethodsAccountIDFavoriteMovie parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get favorite movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get favorite movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                NSLog(@"Favorite movies");
                for (Movie *movie in list.movies) {
                    NSLog(movie.title);
                }
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getRatedMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysSessionID: self.client.sessionID,
                                 kParameterKeysPage: pageString,
                                 kParameterKeysLauguage : @"zh",
                                 kURLKeysID: self.client.user.id};
    [self taskForGetMethod:kMethodsAccountIDRatedMovies parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get rated movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get rated movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                NSLog(@"Rated movies");
                for (Movie *movie in list.movies) {
                    NSLog(movie.title);
                }
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getWatchlistMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysSessionID: self.client.sessionID,
                                 kParameterKeysPage: pageString,
                                 kParameterKeysLauguage : @"zh",
                                 kURLKeysID: self.client.user.id};
    [self taskForGetMethod:kMethodsAccountIDWatchlistMovies parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get rated movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get rated movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                NSLog(@"Watchlist movies");
                for (Movie *movie in list.movies) {
                    NSLog(movie.title);
                }
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getPopularMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysPage: pageString,
                                 kParameterKeysLauguage : @"zh"};
    [self taskForGetMethod:kMethodsPopular parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get popular movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get popular movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getNowplayingMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysPage: pageString,
                                 kParameterKeysLauguage : @"zh"};
    [self taskForGetMethod:kMethodsNowPlaying parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get now_playing movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get now_playing movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getUpcomingMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysPage: pageString,
                                 kParameterKeysLauguage : @"zh"};
    [self taskForGetMethod:kMethodsUpComing parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get up_coming movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get up_coming movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getTopRatedMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysPage: pageString,
                                 kParameterKeysLauguage : @"zh",};
    [self taskForGetMethod:kMethodsTopRated parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get top rated movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get top rated movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(list, nil);
            }
        }
    }];
}

- (NSURLSessionDataTask *)getMoviesForSearchString:(NSString*)searchString WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSDictionary *parameters = @{kParameterKeysQuery: searchString,
                                 kParameterKeysLauguage : @"zh",};
    NSURLSessionDataTask *task;
    task = [self taskForGetMethod:kMethodsSearchMovie parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get searched movies list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get searched movies list(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(list, nil);
            }
        }
    }];
    return task;
}

- (void)getMovieDetailsWithID:(NSString *)id WithCompletionHandler:(void(^)(MovieDetails *movieDetails, NSError *error))completionHandler
{
    NSDictionary *parameters = @{kParameterKeysLauguage : @"zh",
                                 kURLKeysID: id};
    [self taskForGetMethod:kMethodsMovieID parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get movie detail");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            MovieDetails *movieDetails = [[MovieDetails alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get movie detail(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(movieDetails, nil);
            }
        }
    }];
}

- (void)getSimilarMoviesWithID:(NSString *)id WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSDictionary *parameters = @{kURLKeysID : id,
                                 kParameterKeysLauguage : @"zh"};
    [self taskForGetMethod:kMethodsIDSimilarMovies parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get similar movie list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            List *list = [[List alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get similar movie list(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getMovieReviewsWithID:(NSString *)id WithCompletionHandler:(void(^)(MovieReviews *movieReviews, NSError *error))completionHandler
{
    NSDictionary *parameters = @{kURLKeysID : id};
    [self taskForGetMethod:kMethodsIDReviews parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get movie reviews list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            MovieReviews *movieReviews = [[MovieReviews alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get movie reviews list(Parse Data)");
                completionHandler(nil, error);
            } else {
                completionHandler(movieReviews, nil);
            }
        }
    }];
}

- (void)getMovieStatusWithID:(NSString *)id WithCompletionHandler:(void(^)(ZYXMovieStatus *movieStatus, NSError *error))completionHandler
{
    NSDictionary *parameters = @{kURLKeysID : id,
                                 kParameterKeysSessionID: self.client.sessionID};
    [self taskForGetMethod:kMethodsMovieIDAccountStatus parameters:parameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed get movie status list");
            completionHandler(nil, error);
        } else {
            NSError *error = nil;
            ZYXMovieStatus *movieStatus = [[ZYXMovieStatus alloc] initWithData:data error:&error];
            if (error) {
                NSLog(@"Failed get movie Status list(Parse Data)");
                completionHandler(nil, error);
            } else {
                NSLog(@"movieStatus: %ld %d %d %d", (long)movieStatus.id, movieStatus.favorite, movieStatus.rated, movieStatus.watchlist);
                completionHandler(movieStatus, nil);
            }
        }
    }];
}

#pragma mark -
#pragma mark Post Convenience Methods

- (void)postRatingValue:(NSString *)value forMovieWithID:(NSString *)id withCompletionHandler:(void(^)(BOOL succuss))completionHandler
{
    NSDictionary *parameters = @{kURLKeysID : id,
                                 kParameterKeysSessionID: self.client.sessionID};
    NSDictionary *JSONParameters = @{kJSONBodyKeysValue: value};
    [self taskForPostMethod:kMethodsIDRating parameters:parameters JSONBody:JSONParameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed to post movie rating value");
            completionHandler(NO);
        } else {
            NSError *error = nil;
            NSDictionary *parsedResult = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (error) {
                completionHandler(NO);
            } else {
                if ([parsedResult[@"status_message"] isEqualToString:@"Success"]) {
                    completionHandler(YES);
                } else {
                    completionHandler(NO);
                }
            }
        }
    }];
}

- (void)postFavorite:(BOOL)favorite forMovieWithID:(NSString *)id withCompletionHandler:(void(^)(BOOL succuss))completionHandler
{
    NSDictionary *parameters = @{kURLKeysID : id,
                                 kParameterKeysSessionID: self.client.sessionID};
    NSDictionary *JSONParameters;
    if (favorite) {
        JSONParameters = @{kJSONBodyKeysMediaType: @"movie",
                                         kJSONBodyKeysMediaID: id,
                                         kJSONBodyKeysFavorite: @"true"};
    } else {
        JSONParameters = @{kJSONBodyKeysMediaType: @"movie",
                                         kJSONBodyKeysMediaID: id,
                                         kJSONBodyKeysFavorite: @"false"};
    }
    
    [self taskForPostMethod:kMethodsAccountIDFavorite parameters:parameters JSONBody:JSONParameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed to post movie rating value");
            completionHandler(NO);
        } else {
            NSError *error = nil;
            NSDictionary *parsedResult = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (error) {
                completionHandler(NO);
            } else {
                if ([parsedResult[@"status_message"] isEqualToString:@"The item/record was updated successfully"]) {
                    completionHandler(YES);
                } else {
                    completionHandler(NO);
                }
            }
        }
    }];
}

- (void)postWatchlist:(BOOL)watchlist forMovieWithID:(NSString *)id withCompletionHandler:(void(^)(BOOL succuss))completionHandler
{
    NSDictionary *parameters = @{kURLKeysID : id,
                                 kParameterKeysSessionID: self.client.sessionID};
    NSDictionary *JSONParameters;
    if (watchlist) {
        JSONParameters = @{kJSONBodyKeysMediaType: @"movie",
                           kJSONBodyKeysMediaID: id,
                           kJSONBodyKeysFavorite: @"true"};
    } else {
        JSONParameters = @{kJSONBodyKeysMediaType: @"movie",
                           kJSONBodyKeysMediaID: id,
                           kJSONBodyKeysFavorite: @"false"};
    }
    
    [self taskForPostMethod:kMethodsAccountIDFavorite parameters:parameters JSONBody:JSONParameters completionHandler:^(NSData * _Nullable data, NSError *error) {
        if (error) {
            NSLog(@"Failed to post movie rating value");
            completionHandler(NO);
        } else {
            NSError *error = nil;
            NSDictionary *parsedResult = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                completionHandler(NO);
            } else {
                if ([parsedResult[@"status_message"] isEqualToString:@"The item/record was updated successfully"]) {
                    completionHandler(YES);
                } else {
                    completionHandler(NO);
                }
            }
        }
    }];
}












@end
