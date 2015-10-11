//
//  Movie.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+(JSONKeyMapper*)keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end
