//
//  Client.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Client : NSObject <NSCoding>

@property (nonatomic, strong) NSString *sessionID;
@property (nonatomic, strong) User *user;

@end
