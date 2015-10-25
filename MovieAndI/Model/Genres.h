//
//  Genres.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Genres

@end

@interface Genres : JSONModel

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;

@end
