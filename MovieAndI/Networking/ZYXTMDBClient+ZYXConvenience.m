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
                completionHandler(list, nil);
            }
        }
    }];
}

- (void)getPopularMoviesForPage:(int)page WithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    NSString *pageString = [NSString stringWithFormat:@"%d", page];
    NSDictionary *parameters = @{kParameterKeysPage: pageString};
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
    NSDictionary *parameters = @{kParameterKeysPage: pageString};
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
    NSDictionary *parameters = @{kParameterKeysPage: pageString};
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
    NSDictionary *parameters = @{kParameterKeysPage: pageString};
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



















@end
