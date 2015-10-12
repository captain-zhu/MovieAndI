//
//  ZYXPages.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/10.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXPages.h"
#import "ZYXTMDBClient.h"

@implementation ZYXPages

- (instancetype)initWithIndex:(int)index text:(NSString *)text {
    self = [super init];
    if (self) {
        _index = index;
        _title = text;
    }
    return self;
}

- (void)getMoviesWithIndex:(int)index page:(int)page withCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    switch (index) {
        case 0:
            [[ZYXTMDBClient sharedInstance] getPopularMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        case 1:
            [[ZYXTMDBClient sharedInstance] getNowplayingMoviesForPage:page WithCompletionHandler:completionHandler];
        case 2:
            [[ZYXTMDBClient sharedInstance] getUpcomingMoviesForPage:page WithCompletionHandler:completionHandler];
        case 3:
            [[ZYXTMDBClient sharedInstance] getTopRatedMoviesForPage:page WithCompletionHandler:completionHandler];
        default:
            break;
    }
}

+ (NSArray *)allPages {
    
    ZYXPages *page0 = [[ZYXPages alloc] initWithIndex:0 text:@"最流行"];
    ZYXPages *page1 = [[ZYXPages alloc] initWithIndex:1 text:@"正在上映"];
    ZYXPages *page2 = [[ZYXPages alloc] initWithIndex:2 text:@"即将上映"];
    ZYXPages *page3 = [[ZYXPages alloc] initWithIndex:3 text:@"最高评分"];
    return @[page0, page1, page2, page3];
}

@end
