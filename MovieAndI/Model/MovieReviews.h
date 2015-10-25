//
//  MovieReviews.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ReviewDetails.h"

@interface MovieReviews : JSONModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSArray<ReviewDetails> *results;
@property (nonatomic, strong) NSNumber *total_pages;
@property (nonatomic, strong) NSNumber *total_results;

@end
