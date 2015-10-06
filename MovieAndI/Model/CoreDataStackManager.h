//
//  CoreDataStackManager.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStackManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataStackManager *)sharedManager;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
