//
//  ZYXTMDBClient+ZYXConstants.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXTMDBClient.h"

#pragma mark - Constants

extern NSString * const kConstantsApiKey;
extern NSString * const kConstantsBaseURL;
extern NSString * const kConstantsBaseUrlSSL;
extern NSString * const kConstantsAuthorizationURL;
extern NSString * const kConstantsBaseImageURL;

#pragma mark - Account Methods
extern NSString *const kMethodsAccount;
extern NSString *const kMethodsAccountIDList;
extern NSString *const kMethodsAccountIDFavoriteMovie;
extern NSString *const kMethodsAccountIDFavoriteTV;
extern NSString *const kMethodsAccountIDFavorite;
extern NSString *const kMethodsAccountIDRatedMovies;
extern NSString *const kMethodsAccountIDRatedTV;
extern NSString *const kMethodsAccountIDWatchlistMovies;
extern NSString *const kMethodsAccountIDWatchlistTV;
extern NSString *const kMethodsAccountIDWatchlist;


#pragma mark - Authentication Methods
extern NSString *const kMethodsAuthenticationTokenNew;
extern NSString *const kMethodsAuthenticationSessionNew;

#pragma mark - Configuration Methods
extern NSString *const kMethodsConfiguration;

#pragma mark - Search Methods
extern NSString *const kMethodsSearchMovie;
extern NSString *const kMethodsSearchPerson;
extern NSString *const kMethodsSearchCollection;
extern NSString *const kMethodsSearchList;
extern NSString *const kMethodsSearchCompany;
extern NSString *const kMethodsSearchKeyword;
extern NSString *const kMethodsSearchTV;
extern NSString *const kMethodsSearchMulti;

#pragma mark - Movies Methods
extern NSString *const kMethodsMovieID;
extern NSString *const kMethodsMovieIDAccountStatus;
extern NSString *const kMethodsAlternativeTitle;
extern NSString *const kMethodsIDCredits;
extern NSString *const kMethodsIDImage;
extern NSString *const kMethodsIDKeywords;
extern NSString *const kMethodsIDReleases;
extern NSString *const kMethodsIDVideos;//type为trailer时是预告片
extern NSString *const kMethodsIDTranslation;
extern NSString *const kMethodsIDSimilarMovies;
extern NSString *const kMethodsIDReviews;
extern NSString *const kMethodsIDList;
extern NSString *const kMethodsIDChanges;
extern NSString *const kMethodsIDRating;
extern NSString *const kMethodsLatest;
extern NSString *const kMethodsNowPlaying;
extern NSString *const kMethodsPopular;
extern NSString *const kMethodsTopRated;
extern NSString *const kMethodsUpComing;

//流派
#pragma mark - Genres Methods
extern NSString *const kMethodsGenreList;
extern NSString *const kMethodsGenreIDMovie;

#pragma mark - Keyword Methods
extern NSString *const kMethodsKeywordID;
extern NSString *const kMethodsKeywordIDMovie;

#pragma mark - List Methods
extern NSString *const kMethodsListID;
extern NSString *const kMethodsListIDItemStatus;
extern NSString *const kMethodsList;
extern NSString *const kMethodsListIDAddItem;
extern NSString *const kMethodsListIDRemoveItem;
extern NSString *const kMethodsListIDClear;

#pragma mark - Collection Methods
extern NSString *const kMethodsCollectionID;
extern NSString *const kMethodsCollectionIDImage;

#pragma mark - Company Methods
extern NSString *const kMethodsCompanyID;
extern NSString *const kMethodsCompanyIDMovies;

#pragma mark - Discover Methods
extern NSString *const kMethodsDiscoverMovie;
extern NSString *const kMethodsDiscoverTV;

#pragma mark - Credit Methods
extern NSString *const kMethodsCreditID;

#pragma mark - People Methods
extern NSString *const kMethodsPeopleID;
extern NSString *const kMethodsPeopleIDMovieCredits;
extern NSString *const kMethodsPeopleIDTVCredits;
extern NSString *const kMethodsPeopleIDCombinedCredits; // 电影和tv的组合角色信息
extern NSString *const kMethodsPeopleIDImages;
extern NSString *const kMethodsPeopleIDTaggedImages; //标记了的图片
extern NSString *const kMethodsPeoplePopular;
extern NSString *const kMethodsPeopleLatest;

#pragma mark - Review Methods
extern NSString *const kMethodsReviewID;

#pragma mark - TV Methods
extern NSString *const kMethodsTVID;
extern NSString *const kMethodsTVIDAccountStatus;
extern NSString *const kMethodsTVIDAlternativeTitles;
extern NSString *const kMethodsTVIDCredits;
extern NSString *const kMethodsTVIDImages;
extern NSString *const kMethodsTVIDKeywords;
extern NSString *const kMethodsTVIDRating;
extern NSString *const kMethodsTVIDSimilar;
extern NSString *const kMethodsTVIDTranslations;
extern NSString *const kMethodsTVIDVideos;
extern NSString *const kMethodsTVLatest;
extern NSString *const kMethodsTVOnTheAir;//正在上映
extern NSString *const kMethodsTVAiringToday;
extern NSString *const kMethodsTVTopRated;
extern NSString *const kMethodsTVPopular;

#pragma mark - URL Keys

extern NSString *const kURLKeysID;
extern NSString *const kURLKeysErrorStatusMessage;

#pragma mark - Config Keys

extern NSString *const kConfigKeysBaseURL;
extern NSString *const kConfigKeysSecureBaseImageURL;
extern NSString *const kConfigKeysImages;
extern NSString *const kConfigKeysBackdropSizes;
extern NSString *const kConfigKeysLogoSizes;
extern NSString *const kConfigKeysPosterSizes;
extern NSString *const kConfigKeysProfileSizes;
extern NSString *const kConfigKeysStillSizes;

#pragma mark  - Parameter Keys

extern NSString *const kParameterKeysApiKey;
extern NSString *const kParameterKeysSessionID;
extern NSString *const kParameterKeysRequestToken;
extern NSString *const kParameterKeysQuery;
extern NSString *const kParameterKeysPage;
extern NSString *const kParameterKeysLauguage;

#pragma mark  - JSONBodyKeys

extern NSString *const kJSONBodyKeysMediaType;
extern NSString *const kJSONBodyKeysMediaID;
extern NSString *const kJSONBodyKeysFavorite;
extern NSString *const kJSONBodyKeysWatchlist;
extern NSString *const kJSONBodyKeysValue;


#pragma mark - JSONResponseKeys

extern NSString *const kJSONResponseKeysStatusMessage;
extern NSString *const kJSONResponseKeysStatusCode;
extern NSString *const kJSONResponseKeysRequestToken;
extern NSString *const kJSONResponseKeysSessionID;

extern NSString *const kJSONResponseKeysUserID;

extern NSString *const kJSONResponseKeysConfigBaseImageURL;
extern NSString *const kJSONResponseKeysConfigImages;
extern NSString *const kJSONResponseKeysConfigPosterSizes;
extern NSString *const kJSONResponseKeysConfigProfileSizes;

@interface ZYXTMDBClient (ZYXConstants)

@end
