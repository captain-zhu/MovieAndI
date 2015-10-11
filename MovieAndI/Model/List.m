//
//  List.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "List.h"

@implementation List

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"results": @"movies",
                                                       @"total_pages": @"totalPages",
                                                       @"total_results": @"totalResults"
                                                       }];
}

@end
