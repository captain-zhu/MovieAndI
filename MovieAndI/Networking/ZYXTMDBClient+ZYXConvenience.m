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
#import "CoreDataStackManager.h"

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
                            self.sessionID = sessionID;
                            
                            [self getUserInfoWithCompletionHandler:^(BOOL success, USER *user, NSString *errorString) {
                                if (success) {
                                    self.user = user;
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
    
    [self taskForGetMethod:kMethodsAuthenticationTokenNew parameters:parameters completionHandler:^(id resullt, NSError *error) {
        if (error) {
            completionHandler(NO, nil, @"Login Failed.(Request Token)");
        } else {
            NSString *requestToken = (NSString *)(NSDictionary *)resullt[kJSONResponseKeysRequestToken];
            if (requestToken) {
                completionHandler(YES, requestToken, nil);
            } else {
                completionHandler(NO, nil, @"Login Failed.(Request Token)");
            }
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
    
    [self taskForGetMethod:kMethodsAuthenticationSessionNew parameters:parameters completionHandler:^(id resullt, NSError *error) {
        if (error) {
            completionHandler(NO, nil, @"Login failed.(Session ID)");
        } else {
            NSString *session = (NSString *)(NSDictionary *)resullt[kJSONResponseKeysSessionID];
            if (session) {
                completionHandler(YES, session, nil);
            } else {
                completionHandler(NO, nil, @"Login failed.(Session ID)");
            }
        }
    }];
}

// 获得userID
- (void)getUserInfoWithCompletionHandler:(void(^)(BOOL success,USER *user, NSString *errorString))completionHandler
{
    NSDictionary *parameters = @{kParameterKeysSessionID : [ZYXTMDBClient sharedInstance].sessionID};
    
    [self taskForGetMethod:kMethodsAccount parameters:parameters completionHandler:^(id resullt, NSError *error) {
        if (error) {
            completionHandler(NO, nil, @"Get user Info Failed");
        } else {
            USER *parsedUser = [[USER alloc] initWithDictionary:(NSDictionary *)resullt insertIntoManagedObjectContext:[CoreDataStackManager sharedManager].managedObjectContext];
            if (parsedUser) {
                completionHandler(YES, parsedUser, nil);
            } else {
                completionHandler(NO, nil, @"Can't parse dictionary to USER");
            }
        }
    }];
}



















@end
