//
//  Client.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "Client.h"

@implementation Client

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.sessionID = [aDecoder decodeObjectForKey:@"sessionID"];
    self.user = [aDecoder decodeObjectForKey:@"user"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sessionID forKey:@"sessionID"];
    [aCoder encodeObject:self.user forKey:@"user"];
}

@end
