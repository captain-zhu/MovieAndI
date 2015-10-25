//
//  ZYXMovieStatus.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/24.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYXMovieStatus : NSObject

@property (nonatomic) NSInteger *id;
@property (nonatomic) BOOL favorite;
@property (nonatomic) BOOL watchlist;
@property (nonatomic) BOOL rated;
@property (nonatomic) double ratedValue;

- (instancetype)initWithData:(NSData *)data error:(NSError **)error;

@end
