//
//  ZYXMyPages.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMyPages.h"
#import "ZYXTMDBClient.h"

@implementation ZYXMyPages

- (void)getMoviesWithIndex:(int)index page:(int)page withCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    switch (index) {
        case 0:{
            [[ZYXTMDBClient sharedInstance] getWatchlistMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        }
        case 1:{
            [[ZYXTMDBClient sharedInstance] getRatedMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        }
        case 2:{
            [[ZYXTMDBClient sharedInstance] getFavoriteMoviesForPage:page WithCompletionHandler:completionHandler];
            break;
        }
        default:
            break;
    }
}

+ (NSArray *)allPages
{
    static ZYXMyPages *page0;
    static ZYXMyPages *page1;
    static ZYXMyPages *page2;
    if (!page0) {
        page0 = [[ZYXMyPages alloc] initWithIndex:0 text:@"观看列表"];
    }
    if (!page1) {
        page1 = [[ZYXMyPages alloc] initWithIndex:1 text:@"已评分"];
    }
    if (!page2) {
        page2 = [[ZYXMyPages alloc] initWithIndex:2 text:@"喜爱"];
    }
    return @[page0, page1, page2];
}


@end
