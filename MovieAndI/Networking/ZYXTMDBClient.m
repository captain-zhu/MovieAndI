//
//  ZYXTMDBClient.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/2.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXTMDBClient.h"

@implementation ZYXTMDBClient

-(instancetype)init
{
    if ((self = [super init])) {
        self.session = [NSURLSession sharedSession];
    }
    return self;
}

#pragma mark - Shared Instance

+ (ZYXTMDBClient *)sharedInstance
{
    static ZYXTMDBClient *sharedInstance = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (NSDateFormatter *)sharedDateFormatter
{
    static NSDateFormatter *sharedDateFormatter = nil;
    static dispatch_once_t once_t;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDateFormatter = [[NSDateFormatter alloc] init];
        sharedDateFormatter.dateFormat = @"yyyy-mm-dd";
    });
    return sharedDateFormatter;
}

+ (ZYXImageCache *)imageCache
{
    static ZYXImageCache *imageCache = nil;
    static dispatch_once_t once_t;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[ZYXImageCache alloc]init];
    });
    return imageCache;
}

#pragma mark - Hepler method for updating config

- (void)updateConfigWithCompletionHandler:(void(^)(bool didSuccess, NSError *error))completionHandler
{
    NSDictionary *parameters = [[NSDictionary alloc] init];
    
    [self taskForGetMethod:kMethodsConfiguration parameters:parameters completionHandler:^(id resullt, NSError *error) {
        if (error) {
            completionHandler(NO, error);
        } else {
            ZYXConfig *newConfig = [[ZYXConfig alloc]initWithParameters:resullt];
            if (newConfig) {
                self.config = newConfig;
                completionHandler(YES, nil);
            } else {
                completionHandler(NO, [NSError errorWithDomain:@"Config" code:0 userInfo:@{NSLocalizedDescriptionKey: @"未能解析config"}]);
            }
        }
    }];
}



#pragma mark - Get Task

- (NSURLSessionDataTask *)taskForGetMethod:(NSString *)method parameters:(NSDictionary *)parameters completionHandler:(void(^)(id resullt, NSError *error))completionHandler
{
    NSMutableString *subtitutedMethod = method;
    NSMutableDictionary *mutableDictionary = parameters? [parameters mutableCopy]: [NSMutableDictionary new];
    mutableDictionary[kParameterKeysApiKey] = kConstantsApiKey;
    
    if (([method rangeOfString:@"{id}"].location != NSNotFound)) {
        if (!parameters[kURLKeysID]) {
            return nil;
        } else {
            subtitutedMethod = [ZYXTMDBClient subtituteKeyInMethod:method key:@"id" value:parameters[kURLKeysID]].mutableCopy;
            [mutableDictionary removeObjectForKey:kURLKeysID];
        }
    }
    
    NSMutableString *urlString = [kConstantsBaseUrlSSL mutableCopy];
    if (subtitutedMethod) {
        [urlString appendString:subtitutedMethod];
    }
    NSString *escapedString = [ZYXTMDBClient escapedParameters:mutableDictionary];
    [urlString appendString:escapedString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSError *newError = [ZYXTMDBClient errorForData:data withResponse:response withError:error];
            completionHandler(nil, newError);
        } else if ([response isKindOfClass:[NSHTTPURLResponse class]]){
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode >= 200 && statusCode <= 299) {
                if (data) {
                    NSLog(@"Step 3 - taskForResource's completionHandler is invoked.");
                    [ZYXTMDBClient parseJSON:data WithCompletionHandler:completionHandler];
                } else {
                    NSLog(@"Your request dit return any data!");
                }
                
            } else {
                NSLog(@"Your request returned an invalid response!Status Code: %ld", statusCode);
            }
        } else {
            NSLog(@"Your request returned an invalid response!");
        }
    }];
    
    [task resume];
    return task;
};

#pragma mark - Task method for image

- (NSURLSessionTask *)taskForImageWithSize:(NSString *)size filePath:(NSString *)filePath completionHandler:(void(^)(NSData *imageData, NSError *error))completionHandler
{
    NSURL *baseURL= [NSURL URLWithString:self.config.secureBaseImageURL];
    NSURL *url = [[baseURL URLByAppendingPathComponent:size] URLByAppendingPathComponent:filePath];
    
    NSLog(@"%@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSError *newError = [ZYXTMDBClient errorForData:data withResponse:response withError:error];
            completionHandler(nil, newError);
        } else {
            completionHandler(data, nil);
        }
    }];
    [task resume];
    return task;
}

#pragma mark - Post Task

- (NSURLSessionDataTask *)taskForPostMethod:(NSString *)method parameters:(NSDictionary *)parameters JSONBody:(NSDictionary *)jsonBody completionHandler:(void(^)(id resullt, NSError *error))completionHandler
{
    NSMutableString *subtitutedMethod;
    NSMutableDictionary *mutableDictionary = parameters? [parameters mutableCopy]: [NSMutableDictionary new];
    mutableDictionary[kParameterKeysApiKey] = kConstantsApiKey;
    
    if (([method rangeOfString:@"{id}"].location != NSNotFound)) {
        if (!parameters[kURLKeysID]) {
            return nil;
        } else {
            subtitutedMethod = [ZYXTMDBClient subtituteKeyInMethod:method key:@"id" value:parameters[kURLKeysID]].mutableCopy;
            [mutableDictionary removeObjectForKey:kURLKeysID];
        }
    }
    
    NSString *urlString = [[kConstantsBaseUrlSSL stringByAppendingString:subtitutedMethod] stringByAppendingString:[ZYXTMDBClient escapedParameters:mutableDictionary]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSError *jsonBodyError = nil;
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:jsonBody options:NSJSONWritingPrettyPrinted error:&jsonBodyError]];
    if (jsonBodyError) {
        NSLog(@"Set HTTPBody failed");
        return nil;
    }
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSError *newError = [ZYXTMDBClient errorForData:data withResponse:response withError:error];
            completionHandler(nil, newError);
        } else if ([response isKindOfClass:[NSHTTPURLResponse class]]){
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode >= 200 && statusCode <= 299) {
                if (data) {
                    NSLog(@"Step 3 - taskForResource's completionHandler is invoked.");
                    [ZYXTMDBClient parseJSON:data WithCompletionHandler:completionHandler];
                } else {
                    NSLog(@"Your request dit return any data!");
                }
                
            } else {
                NSLog(@"Your request returned an invalid response!Status Code: %ld", statusCode);
            }
        } else {
            NSLog(@"Your request returned an invalid response!");
        }
    }];
    
    [task resume];
    return task;
};


#pragma mark - Helper

// 将方程中的｛｝里的内容替换
+ (NSString *)subtituteKeyInMethod:(NSString *)method key:(NSString *)key value:(NSString *)value
{
    if ([method rangeOfString:[NSString stringWithFormat:@"{%@}", key]].location != NSNotFound) {
        return [method stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}", key] withString:value];
    } else {
        return nil;
    }
}


//Help function. 如果传递回了status message，那么生成个新的error。否则，直接使用之前的error
+ (NSError *)errorForData:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error
{
    if (data == nil) {
        return error;
    }
    
    const NSDictionary *parsedResult = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
    
    if (parsedResult) {
        const NSString *errorMessage = parsedResult[kURLKeysErrorStatusMessage];
        
        if (errorMessage) {
            
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey : errorMessage};
            
            return [NSError errorWithDomain:@"TMDB error" code:1 userInfo:userInfo];
        }
    }
    
    return error;
};

// 将一个原始的json返回一个有用的对象

+ (void)parseJSON:(NSData *)data WithCompletionHandler:(void(^)(id result, NSError *error))completionHandler
{
    NSError *error = nil;
    id parsedResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error){
        completionHandler(nil, error);
    } else {
        NSLog(@"Step 4 - parseJSONWithCompletionHandler is invoked.");
        completionHandler(parsedResult, nil);
    }
}

// 将一个参数的dictionary转变为用于url的string
+ (NSString *)escapedParameters:(NSDictionary *)parameters
{
    NSMutableArray *urlValues = [[NSMutableArray alloc] init];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *stringValue = [NSString stringWithFormat:@"%@", obj];
        NSString *escapedValue = [stringValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *finalString = [(NSString *)key stringByAppendingString:[NSString stringWithFormat:@"=%@", escapedValue]];
        [urlValues addObject:finalString];
    }];
    if (!urlValues || !urlValues.count) {
        return @"";
    } else {
        NSMutableString *returnString = [(@"?") mutableCopy];
        [returnString appendString:[urlValues componentsJoinedByString:@"&"]];
        return returnString;
    }
}

@end


