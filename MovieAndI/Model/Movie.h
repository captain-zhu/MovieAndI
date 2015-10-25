//
//  Movie.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "JSONModel.h"

@protocol Movie

@end

@interface Movie : JSONModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString<Optional> *backdropPath;
@property (nonatomic, strong) NSString<Optional> *originalTitle;
@property (nonatomic, strong) NSString<Optional> *releaseDate;
@property (nonatomic, strong) NSString<Optional> *posterPath;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, assign) float voteAverage;
@property (nonatomic, assign) NSInteger voteCount;
@property (nonatomic, strong) NSString<Optional> *originalLanguage;
@property (nonatomic, strong) NSString<Optional> *overview;
@property (nonatomic, assign) NSNumber<Optional> *popularity;

@end
