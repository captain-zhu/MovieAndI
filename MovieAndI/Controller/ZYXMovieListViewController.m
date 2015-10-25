//
//  ZYXMovieListViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/7.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieListViewController.h"
#import "UIImageView+WebCache.h"
#import "ZYXTMDBClient.h"
#import "List.h"
#import "Movie.h"
#import "ZYXMovieCollectionViewCell.h"
#import "ZYXCollectionViewLayout.h"
#import "StoryBoardUtilities.h"
#import "ZYXMovieListRefreshView.h"
#import "ZYXMovieDetailsViewController.h"
#import "ZYXNavigationController.h"

NSString * const reuseIdentifier = @"MovieListCell";
@interface ZYXMovieListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ZYXNetworkLoadingViewControllerDelegate, ZYXMovieListRefreshViewDelegate>

@property (nonatomic, assign) int requestPage;
@property (nonatomic, assign) CGFloat refreshViewHeight;
@property (nonatomic, strong) ZYXMovieListRefreshView *refreshView;
@end

@implementation ZYXMovieListViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 
#pragma mark Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Collection view did load");
    
    [self setupCollectionView];
    [self requestMovie];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark Lazy var

-(int)requestPage
{
    if (!_requestPage) {
        _requestPage = 1;
    }
    return _requestPage;
}

- (CGFloat)refreshViewHeight
{
    return 200.0f;
}

#pragma mark - 
#pragma mark ContainerView Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ZYXNetworkLoadingViewController"]) {
        self.networkingLoadingViewController = (ZYXNetworkLoadingViewController *)segue.destinationViewController;
        self.networkingLoadingViewController.delegate = self;
    }
}

#pragma mark -
#pragma mark Setup

- (void)setupCollectionView
{
    UIImage *image = [UIImage imageNamed:@"pattern-grey"];
    if (image) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;

    self.refreshView = [[ZYXMovieListRefreshView alloc] initWithFrame:CGRectMake(0, -self.refreshViewHeight, CGRectGetWidth(self.view.bounds), self.refreshViewHeight) ScrollView:self.collectionView];
    self.refreshView.delegate = self;
    [self.refreshView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView insertSubview:self.refreshView atIndex:0];
}

#pragma mark -
#pragma mark Networking Request Methods

- (void)requestMovie
{
    self.networkingLoadingContainerView.alpha = 1;
    [self.networkingLoadingViewController showLoadingView];
    [self requestMoviesWithCompletionHandler:^(List *list, NSError *error) {
        if (error) {
            self.networkingLoadingContainerView.alpha = 1;
            [self.networkingLoadingViewController showErrorView];
        } else {
            if (list.totalResults == 0) {
                self.networkingLoadingContainerView.alpha = 1;
                [self.networkingLoadingViewController showNoContentView];
            } else {
                self.movies = list.movies;
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.networkingLoadingContainerView.alpha = 0;
                    [self.collectionView reloadData];
                });
            }
        }
    }];
}

- (void)requestMoviesWithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    [self.page getMoviesWithIndex:self.page.index page:self.requestPage withCompletionHandler:completionHandler];
}

#pragma mark - 
#pragma mark ZYXNetworkLoadingView Delegate

- (void)retryRequest
{
    [self requestMovie];
}


#pragma mark -
#pragma mark CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYXMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[ZYXMovieCollectionViewCell class]]) {
        if ([self.movies[indexPath.item] isKindOfClass:[Movie class]]) {
            Movie *movie = (Movie *)self.movies[indexPath.item];
            if (movie) {
                if (movie.backdropPath && [movie.backdropPath length] > 0) {
                    NSURL *backdropURL = [[ZYXTMDBClient sharedInstance] getImageUrl:movie.backdropPath withSize:[ZYXTMDBClient sharedInstance].config.backdropSizes[1]];
                    [cell.backdropImageView sd_setImageWithURL:backdropURL placeholderImage:[UIImage imageNamed:@"popcorn-film-party"]];
                } else {
                    cell.backdropImageView.image = [UIImage imageNamed:@"popcorn-film-party"];
                }
                
                if (movie.posterPath && [movie.posterPath length] > 0) {
                    NSURL *posterURL = [[ZYXTMDBClient sharedInstance] getImageUrl:movie.posterPath withSize:[ZYXTMDBClient sharedInstance].config.posterSizes[1]];
                    [cell.posterImageView sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"popcorn-film-party"]];
                } else {
                    cell.posterImageView.image = [UIImage imageNamed:@"popcorn-film-party"];
                }
                
                if (movie.title && [movie.title length] > 0) {
                    cell.titelLabel.text = movie.title;
                } else {
                    cell.titelLabel.hidden = YES;
                }
                
                if (movie.originalTitle && [movie.originalTitle length] != 0) {
                    cell.originalTitleLabel.text = movie.originalTitle;
                } else {
                    cell.originalTitleLabel.hidden = YES;
                }
                
                if (movie.voteAverage) {
                    cell.selfScoreLabel.text = [NSString stringWithFormat:@"%0.1f", movie.voteAverage];
                    cell.starRating.value = movie.voteAverage;
                    cell.starRating.shouldBeginGestureRecognizerBlock = nil;
                } else {
                    cell.selfScoreLabel.hidden = YES;
                    cell.starRating.hidden = YES;
                    cell.topScoreLabel.hidden = YES;
                }
                
                if (movie.releaseDate && [movie.releaseDate length] != 0) {
                    cell.releseDateLabel.text = movie.releaseDate;
                } else {
                    cell.releseDateLabel.hidden = YES;
                }
            }
        } else {
            NSLog(@"It's not a Movie");
        }
    } else {
        NSLog(@"%@", NSStringFromClass([cell class]));
    }
    return cell;
}

#pragma mark - 
#pragma mark CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYXCollectionViewLayout *layout = (ZYXCollectionViewLayout *)self.collectionView.collectionViewLayout;
    CGFloat offset = layout.dragOffset * indexPath.item;
    if (self.collectionView.contentOffset.y == offset) {
        if (self.movies && [self.movies count] >= 1) {
            ZYXNavigationController *navigationController = (ZYXNavigationController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieDetails" class:[ZYXNavigationController class]];
            ZYXMovieDetailsViewController *movieDetailViewController = (ZYXMovieDetailsViewController *)navigationController.viewControllers.firstObject;
            Movie *movie = self.movies[indexPath.item];
            NSLog(@"%ld", [movie.id integerValue]);
            movieDetailViewController.id = [movie.id integerValue];
            movieDetailViewController.MovieTitle = movie.title;
            [self presentViewController:navigationController animated:YES completion:nil];
        }
    } else {
        [self.collectionView setContentOffset:CGPointMake(0, offset) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshView scrollViewDidScroll:scrollView];
    NSArray *cells = self.collectionView.visibleCells;
    CGRect bounds = self.collectionView.bounds;
    for (UICollectionViewCell *cell in cells) {
        if ([cell isKindOfClass:[ZYXMovieCollectionViewCell class]]) {
            ZYXMovieCollectionViewCell *theCell = (ZYXMovieCollectionViewCell *)cell;
            [theCell updateParallaxOffset:bounds];
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.refreshView scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    NSArray *cells = self.collectionView.visibleCells;
    CGRect bounds = self.collectionView.bounds;
    for (UICollectionViewCell *cell in cells) {
        if ([cell isKindOfClass:[ZYXMovieCollectionViewCell class]]) {
            ZYXMovieCollectionViewCell *theCell = (ZYXMovieCollectionViewCell *)cell;
            [theCell updateParallaxOffset:bounds];
        }
    }
}

#pragma mark - 
#pragma mark RefreshViewDelegate

- (void)refreshViewDidRefresh
{
    [self requestMovie];
}

@end
