//
//  ZYXMovieStatus.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/24.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieStatus.h"

@implementation ZYXMovieStatus

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data error:(NSError *__autoreleasing *)error
{
    self = [super init];
    if (self) {
        if (!data) {
            *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Your request returned no data!", nil)}];
            return self;
        } else {
            NSError *err = nil;
            id parsedResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if (err) {
                *error = err;
            }
            if ([parsedResult isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dictionary = (NSDictionary *)parsedResult;
                NSLog(@"dictionary: %@", dictionary);
                if (dictionary[@"id"]) {
                    id theID = dictionary[@"id"];
                    self.id = [theID integerValue];
                } else {
                    *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Your request returned no id!", nil)}];
                    return self;
                }
                
                if (dictionary[@"favorite"]) {
                    id theFavorite = dictionary[@"favorite"];
                    self.favorite = [theFavorite boolValue];
                } else {
                    *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Your request returned no favorite!", nil)}];
                    return self;
                }
                
                if (dictionary[@"rated"]) {
                    id rated = dictionary[@"rated"];
                    if ([dictionary[@"rated"] isKindOfClass:[NSNumber class]]) {
                        self.rated = NO;
                        self.ratedValue = 0;
                    } else {
                        id ratedValue = dictionary[@"rated"][@"value"];
                        if (ratedValue) {
                            self.rated = YES;
                            self.ratedValue = [ratedValue floatValue];
                        } else {
                            *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Your request returned no rated!", nil)}];
                            return self;
                        }
                    }
                } else {
                    *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Your request returned no rated!", nil)}];
                    return self;
                }
                
                if (dictionary[@"watchlist"]) {
                    id theWatchlist = dictionary[@"watchlist"];
                    self.watchlist = [theWatchlist boolValue];
                } else {
                    *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Your request returned no watchlist!", nil)}];
                    return self;
                }
            }
        }
       
    }
    return self;
}

@end
