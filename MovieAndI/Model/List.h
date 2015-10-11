//
//  FavoriteList.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "JSONModel.h"
#import "Movie.h"

@interface List : JSONModel

@property (nonatomic, assign) int page;
@property (nonatomic, assign) int totalPages;
@property (nonatomic, strong) NSString *totalResults;
@property (nonatomic, strong) NSArray<Movie> *movies;


@end
