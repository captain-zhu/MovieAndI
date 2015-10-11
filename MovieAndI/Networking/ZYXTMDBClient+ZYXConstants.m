//
//  ZYXTMDBClient+ZYXConstants.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/5.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXTMDBClient+ZYXConstants.h"

#pragma mark - Constants

NSString * const kConstantsApiKey = @"e45fa92c3312d2f9c219559e40b583c3";
NSString * const kConstantsBaseURL = @"http://api.themoviedb.org/3/";
NSString * const kConstantsBaseUrlSSL = @"https://api.themoviedb.org/3/";
NSString * const kConstantsAuthorizationURL = @"https://www.themoviedb.org/authenticate/";
NSString * const kConstantsBaseImageURL = @"http://image.tmdb.org/t/p/";

#pragma mark - Account Methods
NSString *const kMethodsAccount = @"account";
NSString *const kMethodsAccountIDList = @"account/{id}/lists";
NSString *const kMethodsAccountIDFavoriteTV = @"account/{id}/favorite/tv";
NSString *const kMethodsAccountIDFavoriteMovie = @"account/{id}/favorite/movies";
NSString *const kMethodsAccountIDFavorite = @"account/{id}/favorite";
NSString *const kMethodsAccountIDRatedMovies = @"account/{id}/rated/movies";
NSString *const kMethodsAccountIDRatedTV = @"account/{id}/rated/tv";
NSString *const kMethodsAccountIDWatchlistMovies = @"account/{id}/watchlist/movies";
NSString *const kMethodsAccountIDWatchlistTV = @"account/{id}/watchlist/tv";
NSString *const kMethodsAccountIDWatchlist = @"account/{id}/watchlist";

#pragma mark - Authentication Methods
NSString *const kMethodsAuthenticationTokenNew = @"authentication/token/new";
NSString *const kMethodsAuthenticationSessionNew = @"authentication/session/new";

#pragma mark - Configuration Methods
NSString *const kMethodsConfiguration = @"configuration";

#pragma mark - Search Methods
NSString *const kMethodsSearchMovie = @"search/movie";
NSString *const kMethodsSearchPerson = @"search/person";
NSString *const kMethodsSearchCollection = @"search/collection";
NSString *const kMethodsSearchList = @"search/list";
NSString *const kMethodsSearchCompany = @"search/company";
NSString *const kMethodsSearchKeyword = @"search/keyword";
NSString *const kMethodsSearchTV = @"search/tv";
NSString *const kMethodsSearchMulti = @"search/multi";

#pragma mark - Movies Methods
NSString *const kMethodsMovieID = @"movie/{id}";
NSString *const kMethodsAlternativeTitle = @"movie/{id}/alternative_titles";
NSString *const kMethodsIDCredits = @"movie/{id}/credits";
NSString *const kMethodsIDImage = @"movie/{id}/images";
NSString *const kMethodsIDKeywords = @"movie/{id}/keywords";
NSString *const kMethodsIDReleases = @"movie/{id}/releases";
NSString *const kMethodsIDVideos = @"movie/{id}/videos";//type为trailer时是预告片
NSString *const kMethodsIDTranslation = @"movie/{id}/translations";
NSString *const kMethodsIDSimilarMovies = @"movie/{id}/similar";
NSString *const kMethodsIDReviews = @"movie/{id}/reviews";
NSString *const kMethodsIDList = @"movie/{id}/lists";
NSString *const kMethodsIDChanges = @"movie/{id}/changes";
NSString *const kMethodsIDRating = @"movie/{id}/rating";
NSString *const kMethodsLatest = @"movie/latest";
NSString *const kMethodsNowPlaying = @"movie/now_playing";
NSString *const kMethodsPopular = @"movie/popular";
NSString *const kMethodsTopRated = @"movie/top_rated";
NSString *const kMethodsUpComing = @"movie/upcoming";

//流派
#pragma mark - Genres Methods
NSString *const kMethodsGenreList = @"genre/movie/list";
NSString *const kMethodsGenreIDMovie = @"genre/{id}/movies";

#pragma mark - Keyword Methods
NSString *const kMethodsKeywordID = @"keyword/{id}";
NSString *const kMethodsKeywordIDMovie = @"keyword/{id}/movies";

#pragma mark - List Methods
NSString *const kMethodsListID = @"list/{id}";
NSString *const kMethodsListIDItemStatus = @"list/{id}/item_status";
NSString *const kMethodsList = @"list";
NSString *const kMethodsListIDAddItem = @"list/{id}/add_item";
NSString *const kMethodsListIDRemoveItem = @"list/{id}/remove_item";
NSString *const kMethodsListIDClear = @"list/{id}/clear";

#pragma mark - Collection Methods
NSString *const kMethodsCollectionID = @"collection/{id}";
NSString *const kMethodsCollectionIDImage = @"collection/{id}/images";

#pragma mark - Company Methods
NSString *const kMethodsCompanyID = @"company/{id}";
NSString *const kMethodsCompanyIDMovies = @"company/{id}/movies";

#pragma mark - Discover Methods
NSString *const kMethodsDiscoverMovie = @"discover/movie";
NSString *const kMethodsDiscoverTV = @"discover/tv";

#pragma mark - Credit Methods
NSString *const kMethodsCreditID = @"credit/{credit_id}";

#pragma mark - People Methods
NSString *const kMethodsPeopleID = @"person/{id}";
NSString *const kMethodsPeopleIDMovieCredits = @"person/{id}/movie_credits";
NSString *const kMethodsPeopleIDTVCredits = @"person/{id}/tv_credits";
NSString *const kMethodsPeopleIDCombinedCredits = @"person/{id}/combined_credits"; // 电影和tv的组合角色信息
NSString *const kMethodsPeopleIDImages = @"person/{id}/images";
NSString *const kMethodsPeopleIDTaggedImages = @"/person/{id}/tagged_images"; //标记了的图片
NSString *const kMethodsPeoplePopular = @"person/popular";
NSString *const kMethodsPeopleLatest = @"person/latest";

#pragma mark - Review Methods
NSString *const kMethodsReviewID = @"review/{id}";

#pragma mark - TV Methods
NSString *const kMethodsTVID = @"tv/{id}";
NSString *const kMethodsTVIDAccountStatus = @"tv/{id}/account_states";
NSString *const kMethodsTVIDAlternativeTitles = @"tv/{id}/alternative_titles";
NSString *const kMethodsTVIDCredits = @"tv/{id}/credits";
NSString *const kMethodsTVIDImages = @"tv/{id}/images";
NSString *const kMethodsTVIDKeywords = @"tv/{id}/keywords";
NSString *const kMethodsTVIDRating = @"tv/{id}/rating";
NSString *const kMethodsTVIDSimilar = @"tv/{id}/similar";
NSString *const kMethodsTVIDTranslations = @"tv/{id}/translations";
NSString *const kMethodsTVIDVideos = @"tv/{id}/videos";
NSString *const kMethodsTVLatest = @"tv/latest";
NSString *const kMethodsTVOnTheAir = @"tv/on_the_air";//正在上映
NSString *const kMethodsTVAiringToday = @"tv/airing_today";
NSString *const kMethodsTVTopRated = @"tv/top_rated";
NSString *const kMethodsTVPopular = @"tv/popular";

#pragma mark - URL Keys
NSString *const kURLKeysID = @"id";
NSString *const kURLKeysErrorStatusMessage = @"status_message";

#pragma mark - Config Keys

NSString *const kConfigKeysBaseURL = @"base_url";
NSString *const kConfigKeysSecureBaseImageURL = @"secure_base_url";
NSString *const kConfigKeysImages = @"images";
NSString *const kConfigKeysBackdropSizes = @"backdrop_sizes";
NSString *const kConfigKeysLogoSizes = @"logo_sizes";
NSString *const kConfigKeysPosterSizes = @"poster_sizes";
NSString *const kConfigKeysProfileSizes = @"profile_sizes";
NSString *const kConfigKeysStillSizes = @"still_sizes";

#pragma mark  - Parameter Keys

NSString *const kParameterKeysApiKey = @"api_key";
NSString *const kParameterKeysSessionID = @"session_id";
NSString *const kParameterKeysRequestToken = @"request_token";
NSString *const kParameterKeysQuery = @"query";
NSString *const kParameterKeysPage = @"page";
NSString *const kParameterKeysLauguage = @"language";

#pragma mark  - JSONBodyKeys

NSString *const kJSONBodyKeysMediaType = @"media_type";
NSString *const kJSONBodyKeysMediaID = @"media_id";
NSString *const kJSONBodyKeysFavorite = @"favorite";
NSString *const kJSONBodyKeysWatchlist = @"watchlist";

#pragma mark - JSONResponseKeys

NSString *const kJSONResponseKeysStatusMessage = @"status_message";
NSString *const kJSONResponseKeysStatusCode = @"status_code";
NSString *const kJSONResponseKeysRequestToken = @"request_token";
NSString *const kJSONResponseKeysSessionID = @"session_id";

NSString *const kJSONResponseKeysUserID = @"id";

NSString *const kJSONResponseKeysConfigBaseImageURL = @"secure_base_url";
NSString *const kJSONResponseKeysConfigImages = @"images";
NSString *const kJSONResponseKeysConfigPosterSizes = @"poster_sizes";
NSString *const kJSONResponseKeysConfigProfileSizes = @"profile_sizes";


@implementation ZYXTMDBClient (ZYXConstants)

@end
