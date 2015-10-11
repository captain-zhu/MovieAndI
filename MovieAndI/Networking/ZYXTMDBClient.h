//
//  ZYXTMDBClient.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/2.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYXConfig.h"
#import "Client.h"

@interface ZYXTMDBClient : NSObject

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) Client *client;
@property (nonatomic, strong) ZYXConfig *config;

#pragma mark - Shared Instance
+ (ZYXTMDBClient *)sharedInstance;
+ (NSDateFormatter *)sharedDateFormatter;

#pragma mark - update config helper method
- (void)updateConfigWithCompletionHandler:(void(^)(bool didSuccess, NSError *error))completionHandler;

#pragma mark - Task Methods
- (NSURLSessionDataTask *)taskForGetMethod:(NSString *)method parameters:(NSDictionary *)parameters completionHandler:(void(^)(NSData * _Nullable data, NSError *error))completionHandler;
//- (NSURLSessionTask *)taskForImageWithSize:(NSString *)size filePath:(NSString *)filePath completionHandler:(void(^)(NSData *imageData, NSError *error))completionHandler;
- (NSURLSessionDataTask *)taskForPostMethod:(NSString *)method parameters:(NSDictionary *)parameters JSONBody:(NSDictionary *)jsonBody completionHandler:(void(^)(NSData * _Nullable data, NSError *error))completionHandler;

#pragma mark - Helper Methods
+ (NSString *)subtituteKeyInMethod:(NSString *)method key:(NSString *)key value:(NSString *)value;
+ (NSError *)errorForData:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error;
+ (void)ObjectFromParseJSON:(NSData *)data WithCompletionHandler:(void(^)(id result, NSError *error))completionHandler;
+ (void)StringFromParseJSON:(NSData *)data WithCompletionHandler:(void(^)(NSString *result))completionHandler;
+ (NSString *)escapedParameters:(NSDictionary *)parameters;
- (NSURL *)getImageUrl:(NSString *)urlString withSize:(NSString *)size;

@end

#import "ZYXTMDBClient+ZYXConvenience.h"
#import "ZYXTMDBClient+ZYXConstants.h"