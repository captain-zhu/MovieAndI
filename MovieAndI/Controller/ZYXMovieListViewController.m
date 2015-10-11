//
//  ZYXMovieListViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/7.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieListViewController.h"
#import <UIImageView+WebCache.h>
#import "ZYXTMDBClient.h"
#import "List.h"
#import "Movie.h"
#import "ZYXMovieCollectionViewCell.h"
#import "ZYXCollectionViewLayout.h"

static NSString * const reuseIdentifier = @"MovieListCell";

@interface ZYXMovieListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ZYXNetworkLoadingViewControllerDelegate>

@property (nonatomic, strong) ZYXNetworkLoadingViewController *networkingLoadingViewController;
@property (nonatomic, assign) int requestPage;

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
    [self requestMovies];
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

#pragma mark - 
#pragma mark ContainerView Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ZYXNetworkLoadingViewController"]) {
        self.networkingLoadingViewController = (ZYXNetworkLoadingViewController *)segue.destinationViewController;
        self.networkingLoadingViewController.delegate = self;
    }
}

#pragma mark - Collection View Methods

- (void)setupCollectionView
{
    UIImage *image = [UIImage imageNamed:@"pattern-grey"];
    if (image) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    [self.collectionView registerClass:[ZYXMovieCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark -
#pragma mark Networking Request Methods

- (void)requestMovies
{
    [self.page getMoviesWithIndex:self.page.index page:self.requestPage withCompletionHandler:^(List *list, NSError *error) {
        if (error) {
            [self.networkingLoadingViewController showErrorView];
        } else {
            if ([list.totalResults integerValue] == 0) {
                [self.networkingLoadingViewController showNoContentView];
            } else {
                [self hideLoadingView];
                self.list = list;
                [self.collectionView reloadData];
            }
        }
    }];
}

#pragma mark - 
#pragma mark ZYXNetworkLoadingView Delegate

- (void)retryRequest
{
    [self requestMovies];
}

#pragma mark - 
#pragma mark ZYXNetworkLoadingView Methods

- (void)hideLoadingView
{
//    __weak __block ZYXMovieListViewController *weakSelf = self;
//    [UIView transitionWithView:self.view duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
//        
//        [weakSelf.networkingLoadingContainerView removeFromSuperview];
//        
//    } completion:^(BOOL finished) {
//        
//        [weakSelf.networkingLoadingViewController removeFromParentViewController];
//        weakSelf.networkingLoadingViewController = nil;
//        
//    }];
    self.networkingLoadingContainerView.alpha = 0;
}

#pragma mark -
#pragma mark CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.list.movies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYXMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[ZYXMovieCollectionViewCell class]]) {
        if ([self.list.movies[indexPath.item] isKindOfClass:[Movie class]]) {
            Movie *movie = (Movie *)self.list.movies[indexPath.item];
            if (movie) {
                NSURL *backdropURL = [[ZYXTMDBClient sharedInstance] getImageUrl:movie.backdropPath withSize:[ZYXTMDBClient sharedInstance].config.backdropSizes[1]];
                NSURL *posterURL = [[ZYXTMDBClient sharedInstance] getImageUrl:movie.posterPath withSize:[ZYXTMDBClient sharedInstance].config.posterSizes[1]];
                cell.titelLabel.text = movie.title;
                cell.originalTitleLabel.text = movie.originalTitle;
                cell.selfScoreLabel.text = [NSString stringWithFormat:@"%0.1f", movie.voteAverage];
                [cell.backdropImageView sd_setImageWithURL:backdropURL placeholderImage:[UIImage imageNamed:@"popcorn-film-party"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (error) {
                        NSLog(@"backdrop image error");
                    } else {
                        NSLog(@"backdrop image success");
                    }
                    NSLog([imageURL absoluteString]);
                }];
                [cell.posterImageView sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"popcorn-film-party"]];
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
        //TODO
    } else {
        [self.collectionView setContentOffset:CGPointMake(0, offset) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *cells = self.collectionView.visibleCells;
    CGRect bounds = self.collectionView.bounds;
    for (UICollectionViewCell *cell in cells) {
        if ([cell isKindOfClass:[ZYXMovieCollectionViewCell class]]) {
            ZYXMovieCollectionViewCell *theCell = (ZYXMovieCollectionViewCell *)cell;
            [theCell updateParallaxOffset:bounds];
        }
    }
}























@end
