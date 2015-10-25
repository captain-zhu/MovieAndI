//
//  ZYXMovieDetailsViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/20.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieDetailsViewController.h"
#import "ZYXNetworkLoadingViewController.h"
#import "ZYXTMDBClient.h"
#import "List.h"
#import "MovieReviews.h"
#import "ZYXMovieDetailCell.h"
#import "UIImageView+WebCache.h"
#import "Genres.h"
#import "ZYXMovieDetailsDescriptionCell.h"
#import "ZYXMovieDetailsPopularityCell.h"
#import "ZYXMovieDetailsFavoriteCell.h"
//#import "MovieStatus.h"
#import "ZYXMovieDetailsSimilarMoviesCell.h"
#import "ZYXSimilarMoviesCollectionViewCell.h"
#import "ZYXCommentsCell.h"
#import "ZYXViewAllCommentsCell.h"
#import "ZYXLeaveACommentCell.h"
#import "ReviewDetails.h"
#import "Movie.h"
#import "StoryBoardUtilities.h"
#import "ZYXMovieStatus.h"

@interface ZYXMovieDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) ZYXNetworkLoadingViewController *networkingController;
@property (nonatomic, strong) MovieDetails *movieDetails;
@property (nonatomic, strong) List *similarMovieList;
@property (nonatomic, strong) MovieReviews *movieReviews;
//@property (nonatomic, strong) MovieStatus *movieStatus;
@property (nonatomic, strong) ZYXMovieStatus *movieStatus;


@end

@implementation ZYXMovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    [self requestMovieDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Setup

- (void)setup
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.title = self.title;
}

#pragma mark - 
#pragma mark Prepare For Segue

- (void) prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:[NSString stringWithFormat:@"%@", @"ZYXNetworkLoadingViewController"]])
    {
        self.networkingController = segue.destinationViewController;
        self.networkingController.delegate = self;
    }
}

#pragma mark -
#pragma mark Networking Request Mothods

- (void)requestMovieDetails
{
    [[ZYXTMDBClient sharedInstance] getMovieDetailsWithID:[NSString stringWithFormat:@"%ld", self.id] WithCompletionHandler:^(MovieDetails *movieDetails, NSError *error) {
        if (error) {
            [self.networkingController showErrorView];
        } else {
            if (!movieDetails) {
                [self.networkingController showNoContentView];
            } else {
                self.movieDetails = movieDetails;
                NSLog(@"request Movie Details success");
                [self requestSimilarMovies];
            }
        }
    }];
}

- (void)requestSimilarMovies
{
    [[ZYXTMDBClient sharedInstance] getSimilarMoviesWithID:[NSString stringWithFormat:@"%ld", self.id] WithCompletionHandler:^(List *list, NSError *error) {
        if (error) {
            [self.networkingController showErrorView];
        } else {
            if (!list) {
                [self.networkingController showNoContentView];
            } else {
                self.similarMovieList = list;
                NSLog(@"request Similar movies success");
                [self requestComments];
            }
        }
    }];
}

- (void)requestComments
{
    [[ZYXTMDBClient sharedInstance] getMovieReviewsWithID:[NSString stringWithFormat:@"%ld", self.id] WithCompletionHandler:^(MovieReviews *movieReviews, NSError *error) {
        if (error) {
            [self.networkingController showErrorView];
        } else {
            if (!movieReviews || [movieReviews.results count] <= 0) {
                [self.networkingController showNoContentView];
            } else {
                self.movieReviews = movieReviews;
                NSLog(@"request comments success");
                [self requestStatus];
            }
        }
    }];
}

- (void)requestStatus
{
    [[ZYXTMDBClient sharedInstance] getMovieStatusWithID:[NSString stringWithFormat:@"%ld", self.id] WithCompletionHandler:^(ZYXMovieStatus *movieStatus, NSError *error) {
        if (error) {
            [self.networkingController showErrorView];
        } else {
            if (!movieStatus) {
                [self.networkingController showNoContentView];
            } else {
                self.movieStatus = movieStatus;
                NSLog(@"request Status success");
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.containerView.alpha = 0;
                    [self.tableView reloadData];
                });
            }
        }
    }];
}

#pragma mark -
#pragma mark UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:{
            ZYXMovieDetailCell *movieDetailCell = (ZYXMovieDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"ZYXMovieDetailCell" forIndexPath:indexPath];
            
            if (!self.movieDetails.poster_path || [self.movieDetails.poster_path length] <= 0) {
                movieDetailCell.posterImageView.image = [UIImage imageNamed:@"film_512"];
            } else {
                NSURL *url = [[ZYXTMDBClient sharedInstance] getImageUrl:self.movieDetails.poster_path withSize:[ZYXTMDBClient sharedInstance].config.posterSizes[1]];
                [movieDetailCell.posterImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"film_512"]];
            }
            
            if (!self.movieDetails.title || [self.movieDetails.title length] <= 0) {
                movieDetailCell.titleLabel.text = @"未知";
            } else {
                movieDetailCell.titleLabel.text = self.movieDetails.title;
            }
            
            if (!self.movieDetails.genres || [self.movieDetails.genres count] <= 0) {
                movieDetailCell.generesLabel.text = @"";
            } else {
                movieDetailCell.generesLabel.text = [self processGenresIntoString:self.movieDetails.genres];
            }
            
            cell = movieDetailCell;
            break;
        }
        case 1:{
            ZYXMovieDetailsDescriptionCell *descriptionCell = (ZYXMovieDetailsDescriptionCell *)[tableView dequeueReusableCellWithIdentifier:@"ZYXMovieDetailsDescriptionCell" forIndexPath:indexPath];
            if (!self.movieDetails.overview || [self.movieDetails.overview length] <= 0) {
                descriptionCell.overviewLabel.text = @"";
            } else {
                descriptionCell.overviewLabel.text = self.movieDetails.overview;
            }
            
            cell = descriptionCell;
            break;
        }
        case 2:{
            ZYXMovieDetailsPopularityCell *popularCell = (ZYXMovieDetailsPopularityCell *)[tableView dequeueReusableCellWithIdentifier:@"ZYXMovieDetailsPopularityCell" forIndexPath:indexPath];
            if (!self.movieDetails.vote_average || [self.movieDetails.vote_average length] <= 0) {
                popularCell.voteAverageLabel.text = @"?";
                popularCell.ratingCircle.currentValue = 0;
            } else {
                popularCell.voteAverageLabel.text = self.movieDetails.vote_average;
                popularCell.ratingCircle.currentValue = [self.movieDetails.vote_average floatValue];
            }
            
            if (!self.movieDetails.vote_count || [self.movieDetails.vote_count length] <= 0) {
                popularCell.voteCountLabel.text = @"0";
            } else {
                popularCell.voteCountLabel.text = self.movieDetails.vote_count;
            }
            
            if (!self.movieDetails.popularity || [self.movieDetails.popularity floatValue] <= 0) {
                popularCell.popularityLabel.text = @"?";
            } else {
                popularCell.popularityLabel.text = [NSString stringWithFormat:@"%0.1f", [self.movieDetails.popularity floatValue]];
            }
            
            cell = popularCell;
            break;
        }
        case 3:{
            ZYXMovieDetailsFavoriteCell *favoriteCell = (ZYXMovieDetailsFavoriteCell *)[tableView dequeueReusableCellWithIdentifier:@"ZYXMovieDetailsFavoriteCell" forIndexPath:indexPath];
            if (self.movieStatus.favorite) {
                favoriteCell.favoriteButton.titleLabel.text = @"在喜爱列表中";
                favoriteCell.favoriteButton.titleLabel.textColor = [UIColor orangeColor];
                favoriteCell.favoriteButton.imageView.tintColor = [UIColor redColor];
                favoriteCell.favoriteButton.imageView.image = [UIImage imageNamed:@"heart_128-Small-40"];
            } else {
                favoriteCell.favoriteButton.titleLabel.textColor = [UIColor grayColor];
                favoriteCell.favoriteButton.titleLabel.text = @"添加到喜爱列表中";
                favoriteCell.favoriteButton.imageView.image = [UIImage imageNamed:@"heart_128-Small-40"];
                favoriteCell.favoriteButton.imageView.tintColor = [UIColor grayColor];
            }
            
            if (self.movieStatus.rated && self.movieStatus.ratedValue > 0 && self.movieStatus.ratedValue <= 10) {
                favoriteCell.ratingLabel.text = [NSString stringWithFormat:@"%.1f", self.movieStatus.ratedValue];
                favoriteCell.starRatingView.value = self.movieStatus.ratedValue;
            } else {
                favoriteCell.ratingLabel.text = @"?";
            }
            
            if (self.movieStatus.watchlist) {
                favoriteCell.watchListButton.titleLabel.text = @"在观看列表中";
                favoriteCell.watchListButton.titleLabel.textColor = [UIColor orangeColor];
                favoriteCell.watchListButton.imageView.image = [UIImage imageNamed:@"list_128"];
                favoriteCell.watchListButton.imageView.tintColor = [UIColor redColor];
            } else {
                favoriteCell.watchListButton.titleLabel.text = @"添加到观看列表中";
                favoriteCell.watchListButton.titleLabel.textColor = [UIColor orangeColor];
                favoriteCell.watchListButton.imageView.image = [UIImage imageNamed:@"list_128"];
                favoriteCell.watchListButton.imageView.tintColor = [UIColor grayColor];
            }
            
            [favoriteCell.starRatingView addTarget:self action:@selector(starRatingViewdidChangeValue:) forControlEvents:UIControlEventValueChanged];
            [favoriteCell.favoriteButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [favoriteCell.watchListButton addTarget:self action:@selector(watchListButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell = favoriteCell;
        }
        case 4:{
            ZYXMovieDetailsSimilarMoviesCell *similarMoviesCell = (ZYXMovieDetailsSimilarMoviesCell *)[tableView dequeueReusableCellWithIdentifier:@"ZYXMovieDetailsSimilarMoviesCell" forIndexPath:indexPath];
            similarMoviesCell.collectionView.contentInset = UIEdgeInsetsZero;
            cell = similarMoviesCell;
        }
        case 5:{
            ZYXCommentsCell *commentCell = (ZYXCommentsCell *)[tableView dequeueReusableCellWithIdentifier:@"ZYXCommentsCell" forIndexPath:indexPath];
            if (!self.movieReviews.results || [self.movieReviews.results count] <= 0) {
                commentCell.userNameLabel.text = @"未知";
                commentCell.commentLabel.text = @"该电影无人评论";
                [commentCell.cellImageView setImage:[UIImage imageNamed:@"coffee_big"]];
            } else {
                ReviewDetails *reviewDetails = [self.movieReviews.results firstObject];
                if (!reviewDetails.author) {
                    commentCell.userNameLabel.text = @"未知";
                } else {
                    commentCell.userNameLabel.text = reviewDetails.author;
                }
                if (!reviewDetails.content) {
                    commentCell.commentLabel.text = @"无内容";
                } else {
                    commentCell.commentLabel.text = reviewDetails.content;
                }
                if (!reviewDetails.url) {
                    commentCell.cellImageView.image = [UIImage imageNamed:@"infos_icon"];
                } else {
                    NSURL *finalURL = [[ZYXTMDBClient sharedInstance] getImageUrl:reviewDetails.url withSize:[ZYXTMDBClient sharedInstance].config.profileSizes[1]];
                    [commentCell.cellImageView sd_setImageWithURL:finalURL placeholderImage:[UIImage imageNamed:@"infos_icon"]];
                }
            }
            cell = commentCell;
        }
        case 6:{
            ZYXViewAllCommentsCell *viewAllCommentsCell = (ZYXViewAllCommentsCell *)[tableView dequeueReusableCellWithIdentifier:@"ZYXViewAllCommentsCell" forIndexPath:indexPath];
            [viewAllCommentsCell.viewAllCommentsButton addTarget:self action:@selector(viewAllCommentsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            cell = viewAllCommentsCell;
        }
            
        default:
            break;
    }
    return cell;
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    switch (indexPath.row) {
        case 0:{
            height = 120;
            break;
        }
        case 1:{
            height = 119;
            break;
        }
        case 2:{
            height = 67;
            break;
        }
        case 3:{
            height = 67;
            break;
        }
        case 4:{
            if ([self.similarMovieList.movies count] <= 0) {
                height = 0;
            } else {
                height = 96;
            }
            break;
        }
        case 6:{
            height = 46;
            break;
        }
            
        default:{
            height = 100;
            break;
        }
    }
    return height;
}

#pragma mark -
#pragma mark Target Methods

- (void)starRatingViewdidChangeValue:(HCSStarRatingView *)sender
{
    NSLog(@"Changed rating to %.1f", sender.value);
    [[ZYXTMDBClient sharedInstance] postRatingValue:[NSString stringWithFormat:@"%.1f", sender.value] forMovieWithID:[NSString stringWithFormat:@"%ld", self.id] withCompletionHandler:^(BOOL succuss) {
        if (!succuss) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传评分失败" message:@"按返回键返回" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

- (void)favoriteButtonPressed:(UIButton *)sender
{
    
    [[ZYXTMDBClient sharedInstance] postFavorite:!self.movieStatus.favorite forMovieWithID:[NSString stringWithFormat:@"%ld", self.id] withCompletionHandler:^(BOOL succuss) {
        if (!succuss) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新喜爱列表状态失败" message:@"按返回键返回" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

- (void)watchListButtonPressed:(UIButton *)sender
{
    
    [[ZYXTMDBClient sharedInstance] postFavorite:!self.movieStatus.watchlist forMovieWithID:[NSString stringWithFormat:@"%ld", self.id] withCompletionHandler:^(BOOL succuss) {
        if (!succuss) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新喜爱列表状态失败" message:@"按返回键返回" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - 
#pragma mark UICollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.similarMovieList.movies ? [self.similarMovieList.movies count] : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYXSimilarMoviesCollectionViewCell *cell = (ZYXSimilarMoviesCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ZYXSimilarMoviesCollectionViewCell" forIndexPath:indexPath];
    Movie *movie = (Movie *)self.similarMovieList.movies[indexPath.item];
    if (!movie.posterPath) {
        cell.posterImageView.image = [UIImage imageNamed:@"film_512"];
    } else {
        NSURL *url = [[ZYXTMDBClient sharedInstance] getImageUrl:movie.posterPath withSize:[ZYXTMDBClient sharedInstance].config.posterSizes[1]];
        [cell.posterImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"film_512"]];
    }
    return cell;
}

#pragma mark = 
#pragma mark UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYXMovieDetailsViewController *movieDetailViewController = (ZYXMovieDetailsViewController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieDetails" class:[ZYXMovieDetailsViewController class]];
    Movie *movie = (Movie *)self.similarMovieList.movies[indexPath.item];
    movieDetailViewController.id = [movie.id integerValue];
    movieDetailViewController.MovieTitle = movie.title;
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
}

#pragma mark -
#pragma mark Help Methods

- (NSString*)processGenresIntoString:(NSArray*)genres
{
    NSMutableString* genresString = [[NSMutableString alloc] init];
    for (Genres* genre in genres)
        [genresString appendFormat:@"%@, ", genre.name];
    [genresString replaceCharactersInRange:NSMakeRange([genresString length]-2, 2) withString:@""];
    return genresString;
}

@end
