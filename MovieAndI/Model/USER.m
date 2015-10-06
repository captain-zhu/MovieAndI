//
//  USER.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "USER.h"

NSString *const kJSONID = @"id";
NSString *const kJSONName = @"name";
NSString *const kJSONUserName = @"username";

@implementation USER

// Insert code here to add functionality to your managed object subclass
- (NSManagedObject *)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    if (self) {
        
    }
    return self;
}

//方便初始化
- (instancetype)initWithDictionary:(NSDictionary *)dictionary insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"USER" inManagedObjectContext:context];
    
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];;
    if (self) {
        if ([dictionary objectForKey:kJSONID] != [NSNull null]) {
            self.id = dictionary[kJSONID];
        }
        
        if ([dictionary objectForKey:kJSONName] != [NSNull null]) {
            self.name = dictionary[kJSONName];
        }
        
        if ([dictionary objectForKey:kJSONUserName] != [NSNull null]) {
            self.userName = dictionary[kJSONUserName];
        }
    }
    
    return self;
}

@end
