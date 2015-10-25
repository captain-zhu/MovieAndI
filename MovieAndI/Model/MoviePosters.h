//
//  MoviePosters.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol MoviePosters

@end

@interface MoviePosters : JSONModel

@property (nonatomic, strong) NSString<Optional> *file_path;
@property (nonatomic, strong) NSNumber<Optional> *width;
@property (nonatomic, strong) NSNumber<Optional> *height;
@property (nonatomic, strong) NSNumber<Optional> *aspect_ratio;
@property (nonatomic, strong) NSNumber<Optional> *vote_average;
@property (nonatomic, strong) NSNumber<Optional> *vote_count;

@end
