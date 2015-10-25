//
//  MovieStatus.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MovieRated.h"

@interface MovieStatus : JSONModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic) BOOL favorite;
@property (nonatomic) BOOL watchlist;
@property (nonatomic, strong) MovieRated<Optional> *rated;

@end
