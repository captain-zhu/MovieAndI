//
//  ZYXTMDBClient.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/2.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYXTMDBConstants.h"
#import "ZYXImageCache.h"
#import "ZYXConfig.h"

@interface ZYXTMDBClient : NSObject

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSString *sessionID;
@property (nonatomic) NSInteger userID;
@property (nonatomic, strong) ZYXConfig *config;

#pragma mark - Shared Instance
+ (ZYXTMDBClient *)sharedInstance;
+ (NSDateFormatter *)sharedDateFormatter;
+ (ZYXImageCache *)imageCache;

#pragma mark - update config helper method
- (void)updateConfigWithCompletionHandler:(void(^)(bool didSuccess, NSError *error))completionHandler;

#pragma mark - Task Methods
- (NSURLSessionDataTask *)taskForGetMethod:(NSString *)method parameters:(NSDictionary *)parameters completionHandler:(void(^)(id resullt, NSError *error))completionHandler;
- (NSURLSessionTask *)taskForImageWithSize:(NSString *)size filePath:(NSString *)filePath completionHandler:(void(^)(NSData *imageData, NSError *error))completionHandler;

#pragma mark - Helper Methods
+ (NSString *)subtituteKeyInMethod:(NSString *)method key:(NSString *)key value:(NSString *)value;
+ (NSError *)errorForData:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error;
+ (void)parseJSON:(NSData *)data WithCompletionHandler:(void(^)(id result, NSError *error))completionHandler;
+ (NSString *)escapedParameters:(NSDictionary *)parameters;

@end
