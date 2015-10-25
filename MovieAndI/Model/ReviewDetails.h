//
//  ReviewDetails.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ReviewDetails

@end

@interface ReviewDetails : JSONModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString<Optional> *author;
@property (nonatomic, strong) NSString<Optional> *content;
@property (nonatomic, strong) NSString<Optional> *url;

@end
