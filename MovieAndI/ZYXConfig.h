//
//  ZYXConfig.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/4.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYXConfig : NSObject<NSCoding>

@property (nonatomic, strong, readonly) NSString *baseImageURL;
@property (nonatomic, strong, readonly) NSString *secureBaseImageURL;
@property (nonatomic, strong, readonly) NSArray *backdropSizes;//背景大小
@property (nonatomic, strong, readonly) NSArray *logoSizes;
@property (nonatomic, strong, readonly) NSArray *posterSizes;//海报大小
@property (nonatomic, strong, readonly) NSArray *profileSizes;//轮廓图大小
@property (nonatomic, strong, readonly) NSArray *stillSizes;//静物大小

@property (nonatomic, strong, readonly) NSDate *dateUpdated;

- (instancetype)initWithParameters:(NSDictionary *)dictionary;

@end
