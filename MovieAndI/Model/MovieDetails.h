//
//  MovieDetails.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Genres.h"

@interface MovieDetails : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString<Optional> *overview;
@property (nonatomic, strong) NSString<Optional> *release_date;
@property (nonatomic, strong) NSString<Optional> *backdrop_path;
@property (nonatomic, strong) NSString<Optional> *poster_path;
@property (nonatomic, strong) NSArray<Genres> *genres;
@property (nonatomic, strong) NSString<Optional> *vote_average;
@property (nonatomic, strong) NSString<Optional> *vote_count;
@property (nonatomic, strong) NSNumber<Optional> *popularity;

@end
