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


@end
