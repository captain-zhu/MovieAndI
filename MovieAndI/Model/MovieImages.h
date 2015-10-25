//
//  MovieImages.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Backdrops.h"
#import "MoviePosters.h"

@interface MovieImages : JSONModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSArray<Backdrops> *backdrops;
@property (nonatomic, strong) NSArray<MoviePosters> *posters;

@end
