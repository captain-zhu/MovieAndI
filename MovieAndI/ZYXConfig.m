//
//  ZYXConfig.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/4.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
// 储存用于获取the movie db 的image的基本信息
// 懒加载储存了目前的基本信息
// updateconfig函数用于更新最新的信息

#import "ZYXConfig.h"
#import "ZYXTMDBClient.h"


NSString *const BaseImageURLStringKey = @"config.base_image_url_string_key";
NSString *const SecureBaseImageURLStringKey =  @"config.secure_base_image_url_key";
NSString *const BackdropSizesKey = @"config.backdrop_size_key";
NSString *const LogoSizesKey = @"config.backdrop_size_key";
NSString *const PosterSizesKey = @"config.poster_size_key";
NSString *const ProfileSizesKey = @"config.profile_size_key";
NSString *const StillSizesKey = @"config.still_size_key";
NSString *const DateUpdatedKey = @"config.date_update_key";
@interface ZYXConfig()

@property (nonatomic, strong, readwrite) NSString *baseImageURL;
@property (nonatomic, strong, readwrite) NSString *secureBaseImageURL;
@property (nonatomic, strong, readwrite) NSArray *backdropSizes;//背景大小
@property (nonatomic, strong, readwrite) NSArray *logoSizes;
@property (nonatomic, strong, readwrite) NSArray *posterSizes;//海报大小
@property (nonatomic, strong, readwrite) NSArray *profileSizes;//轮廓图大小
@property (nonatomic, strong, readwrite) NSArray *stillSizes;//静物大小
@property (nonatomic, strong, readwrite) NSDate *dateUpdated;

@end

@implementation ZYXConfig

#pragma mark - Lazy instanize
- (NSString *)baseImageURL {
    if(_baseImageURL == nil || [_baseImageURL length] == 0) {
        _baseImageURL = @"http://image.tmdb.org/t/p/";
    }
    return _baseImageURL;
}

- (NSString *)secureBaseImageURL {
    if(_secureBaseImageURL == nil || [_baseImageURL length] == 0) {
        _secureBaseImageURL = @"https://image.tmdb.org/t/p/";
    }
    return _secureBaseImageURL;
}

- (NSArray *)backdropSizes {
    if(_backdropSizes == nil) {
        _backdropSizes = [[NSArray alloc] init];
        _backdropSizes = @[
                           @"w300",
                           @"w780",
                           @"w1280",
                           @"original"
                           ];
    }
    return _backdropSizes;
}

- (NSArray *)logoSizes {
    if(_logoSizes == nil) {
        _logoSizes = [[NSArray alloc] init];
        _logoSizes = @[
                       @"w45",
                       @"w92",
                       @"w154",
                       @"w185",
                       @"w300",
                       @"w500",
                       @"original"
                       ];
    }
    return _logoSizes;
}

- (NSArray *)posterSizes {
    if(_posterSizes == nil) {
        _posterSizes = [[NSArray alloc] init];
        _posterSizes = @[
                        @"w92",
                        @"w154",
                        @"w185",
                        @"w342",
                        @"w500",
                        @"w780",
                        @"original"
                        ];
    }
    return _posterSizes;
}

- (NSArray *)profileSizes {
    if(_profileSizes == nil) {
        _profileSizes = [[NSArray alloc] init];
        _profileSizes = @[
                          @"w45",
                          @"w185",
                          @"h632",
                          @"original"
                          ];
    }
    return _profileSizes;
}

- (NSArray *)stillSizes {
    if(_stillSizes == nil) {
        _stillSizes = [[NSArray alloc] init];
        _stillSizes = @[
                        @"w92",
                        @"w185",
                        @"w300",
                        @"original"
                        ];
    }
    return _stillSizes;
}

#pragma mark - File support

+ (NSURL *)documentsDirectoryURL {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}


+ (NSURL *)fileURL {
	return [[ZYXConfig documentsDirectoryURL]   URLByAppendingPathComponent:@"MovieAndI-context"];
}

#pragma mark - init

- (instancetype)init
{
    if ((self = [super init])) {
        
    }
    return self;
}

// convenience init
- (instancetype)initWithParameters:(NSDictionary *)dictionary
{
    self = [self init];
    NSDictionary *imageDictionary = dictionary[kConfigKeysImages];
    if (imageDictionary) {
        NSString *urlString = imageDictionary[kConfigKeysBaseURL];
        if (urlString == nil || [urlString length] == 0) {
            return nil;
        } else {
            _baseImageURL = urlString;
        }
        
        NSString *secureURLString = imageDictionary[kConfigKeysSecureBaseImageURL];
        if (secureURLString == nil || [urlString length] == 0) {
            return nil;
        } else {
            _secureBaseImageURL = secureURLString;
        }
        
        NSArray *backdropSizeArray = [[NSArray alloc] init];
        backdropSizeArray = imageDictionary[kConfigKeysBackdropSizes];
        if (!backdropSizeArray) {
            return nil;
        } else {
            _backdropSizes = backdropSizeArray;
        }
        
        NSArray *logoSizeArray = [[NSArray alloc] init];
        logoSizeArray = imageDictionary[kConfigKeysLogoSizes];
        if (!logoSizeArray) {
            return nil;
        } else {
            _logoSizes = logoSizeArray;
        }
        
        NSArray *posterSizeArray = [[NSArray alloc] init];
        posterSizeArray = imageDictionary[kConfigKeysPosterSizes];
        if (!posterSizeArray) {
            return nil;
        } else {
            _posterSizes = posterSizeArray;
        }
        
        NSArray *profileSizeArray = [[NSArray alloc] init];
        profileSizeArray = imageDictionary[kConfigKeysProfileSizes];
        if (!profileSizeArray) {
            return nil;
        } else {
            _profileSizes = profileSizeArray;
        }
        
        NSArray *stillSizeArray = [[NSArray alloc] init];
        stillSizeArray = imageDictionary[kConfigKeysStillSizes];
        if (!stillSizeArray) {
            return  nil;
        } else {
            _stillSizes = stillSizeArray;
        }
        
        return self;
    } else {
        return nil;
    }
}

#pragma mark - Updated date

//计算距离上次更新的时间
- (NSInteger)daysSinceLastUpdate
{
    if (self.dateUpdated) {
        return (NSInteger)([[[NSDate alloc]init] timeIntervalSinceDate:self.dateUpdated]) / (60 * 60 * 24);
    } else {
        return -1;
    }
}

- (void)updateIfDaysSinceUpdateExceeds:(NSInteger)days
{
    NSInteger daysSinceUpdate = [self daysSinceLastUpdate];
    if (daysSinceUpdate == -1 || daysSinceUpdate <= days) {
        return;
    } else {
        [[ZYXTMDBClient sharedInstance] updateConfigWithCompletionHandler:^(bool didSuccess, NSError *error) {
            if (error) {
                NSLog(@"更新config时出现错误：%@", error.localizedDescription);
            } else {
                if (didSuccess) {
                    NSLog(@"更新成功");
                    [[ZYXTMDBClient sharedInstance].config save];
                }else {
                    NSLog(@"更新失败");
                }
            }
        }];
    }
}


#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.baseImageURL = [aDecoder decodeObjectForKey:BaseImageURLStringKey];
        self.secureBaseImageURL = [aDecoder decodeObjectForKey:SecureBaseImageURLStringKey];
        self.backdropSizes = [aDecoder decodeObjectForKey:BackdropSizesKey];
        self.logoSizes = [aDecoder decodeObjectForKey:LogoSizesKey];
        self.posterSizes = [aDecoder decodeObjectForKey:PosterSizesKey];
        self.profileSizes = [aDecoder decodeObjectForKey:PosterSizesKey];
        self.stillSizes = [aDecoder decodeObjectForKey:StillSizesKey];
        self.dateUpdated = [aDecoder decodeObjectForKey:DateUpdatedKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.baseImageURL forKey:BaseImageURLStringKey];
    [aCoder encodeObject:self.secureBaseImageURL forKey:SecureBaseImageURLStringKey];
    [aCoder encodeObject:self.backdropSizes forKey:BackdropSizesKey];
    [aCoder encodeObject:self.logoSizes forKey:LogoSizesKey];
    [aCoder encodeObject:self.posterSizes forKey:PosterSizesKey];
    [aCoder encodeObject:self.profileSizes forKey:ProfileSizesKey];
    [aCoder encodeObject:self.stillSizes forKey:StillSizesKey];
    [aCoder encodeObject:self.dateUpdated forKey:DateUpdatedKey];
}

- (void)save
{
    [NSKeyedArchiver archiveRootObject:self toFile:[ZYXConfig fileURL].path];
}

+ (ZYXConfig *)unarchedInstance
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:[ZYXConfig fileURL].path]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[ZYXConfig fileURL].path];
    } else {
        return nil;
    }
}







































@end
