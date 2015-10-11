//
//  ZYXPages.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/10.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "List.h"

@interface ZYXPages : NSObject

@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSString *title;

- (instancetype)initWithIndex:(int)index text:(NSString *)text;
- (void)getMoviesWithIndex:(int)index page:(int)page withCompletionHandler:(void(^)(List *list, NSError *error))completionHandler;

+ (NSArray *)allPages;

@end
