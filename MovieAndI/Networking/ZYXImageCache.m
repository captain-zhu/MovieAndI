//
//  ZYXImageCache.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/4.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXImageCache.h"

@interface ZYXImageCache()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation ZYXImageCache

#pragma mark - retreiving images

- (UIImage *)imageWithIdentifier:(NSString *)identifier
{
    if (identifier == nil || [identifier length] == 0) {
        return nil;
    }
    
    NSString *const path = [self pathForIdentifier:identifier];
    
    //试试缓存里能否找到image
    UIImage *image = [self.cache objectForKey:path];
    if (image) {
        return image;
    }
    
    //如果缓存里找不到，试试硬盘里能否找到image
    NSData *const data = [NSData dataWithContentsOfFile:path];
    if (data) {
        return [UIImage imageWithData:data];
    }
    
    return nil;
}

#pragma mark - saving images

- (void)storeImage:(UIImage *)image withIdentifer:(NSString *)identifier
{
    NSString *const path = [self pathForIdentifier:identifier];
    
    //如果要储存的image为nil，那么清空缓存
    if (image == nil) {
        NSError *error = nil;
        [self.cache removeObjectForKey:identifier];
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        return;
    }
    
    // 否则，将图片存着内存中和硬盘里
    [self.cache setValue:image forKey:path];
    NSData *const data = UIImagePNGRepresentation(image);
    [data writeToFile:path atomically:YES];
}

#pragma mark - Helper methods

- (NSString *)pathForIdentifier:(NSString *)identifier
{
    NSURL *const documentDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *const finalURL = [documentDirectoryURL URLByAppendingPathComponent:identifier];
    
    return finalURL.path;
}

#pragma mark - Property
- (NSCache *)cache {
	if(_cache == nil) {
		_cache = [[NSCache alloc] init];
	}
	return _cache;
}

@end
