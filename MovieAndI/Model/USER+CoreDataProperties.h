//
//  USER+CoreDataProperties.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "USER.h"

NS_ASSUME_NONNULL_BEGIN

@interface USER (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *userName;

@end

NS_ASSUME_NONNULL_END
