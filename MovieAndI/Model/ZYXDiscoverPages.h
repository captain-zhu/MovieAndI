//
//  ZYXDiscoverPages.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXPages.h"

@interface ZYXDiscoverPages : ZYXPages

- (void)getMoviesWithIndex:(int)index page:(int)page withCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;
+ (NSArray *)allPages;

@end
