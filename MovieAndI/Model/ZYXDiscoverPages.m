//
//  ZYXDiscoverPages.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXDiscoverPages.h"
#import "ZYXTMDBClient.h"

@implementation ZYXDiscoverPages


- (void)getMoviesWithIndex:(int)index page:(int)page withCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    switch (index) {
        case 0:
            [[ZYXTMDBClient sharedInstance] getPopularMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        case 1:
            [[ZYXTMDBClient sharedInstance] getNowplayingMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        case 2:
            [[ZYXTMDBClient sharedInstance] getUpcomingMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        case 3:
            [[ZYXTMDBClient sharedInstance] getTopRatedMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        default:
            break;
    }
}

+ (NSArray *)allPages {
    static ZYXDiscoverPages *page0;
    static ZYXDiscoverPages *page1;
    static ZYXDiscoverPages *page2;
    static ZYXDiscoverPages *page3;
    if (!page0) {
        page0 = [[ZYXDiscoverPages alloc] initWithIndex:0 text:@"最流行"];
    }
    if (!page1) {
        page1 = [[ZYXDiscoverPages alloc] initWithIndex:1 text:@"正在上映"];
    }
    if (!page2) {
        page2 = [[ZYXDiscoverPages alloc] initWithIndex:2 text:@"即将上映"];
    }
    if (!page3) {
        page3 = [[ZYXDiscoverPages alloc] initWithIndex:3 text:@"最高评分"];
    }
    return @[page0, page1, page2, page3];
}

@end
