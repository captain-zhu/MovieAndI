//
//  User.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/9.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.id = [aDecoder decodeObjectForKey:@"id"];;
    self.username = [aDecoder decodeObjectForKey:@"username"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.id forKey:@"id"];
}
@end
