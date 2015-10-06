//
//  USER.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString *const kJSONID;
extern NSString *const kJSONName;
extern NSString *const kJSONUserName;
@interface USER : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

//用dictionary初始化用户
- (instancetype)initWithDictionary:(NSDictionary *)dictionary insertIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "USER+CoreDataProperties.h"
