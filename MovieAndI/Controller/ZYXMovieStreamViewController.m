//
//  ZYXMovieStreamViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/13.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieStreamViewController.h"
#import "ZYXMovieCollectionViewFlowLayout.h"
#import "ZYXNetworkLoadingViewController.h"
#import "ZYXMovieFlowCollectionViewCell.h"
#import "ZYXTMDBClient.h"
#import "UIImageView+WebCache.h"
#import "ZYXContainerViewController.h"
#import "StoryBoardUtilities.h"
#import "ZYXNavigationController.h"
#import "ZYXMovieDetailsViewController.h"

static NSString * const reuseIdentifier = @"MovieCollectionFlowCell";
@interface ZYXMovieStreamViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ZYXNetworkLoadingViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) ZYXNetworkLoadingViewController *networkingLoadingViewController;
@property (nonatomic, assign) int requestPage;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation ZYXMovieStreamViewController

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
    
    [self setupMenuButton];
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
#pragma mark Setup Methods

- (void)setupMenuButton
{
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:self.page.title];
    ZYXMenuButton *button = [[ZYXMenuButton alloc] init];
    button.tapHandler = ^(){
        ZYXContainerViewController *containerController = (ZYXContainerViewController *)self.parentViewController;
        [containerController toggleSideMenu];
    };
    self.menuButton = button;
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationBar.items = @[navigationItem];
}

- (void)setupCollectionView
{
    UIImage *image = [UIImage imageNamed:@"pattern-grey"];
    if (image) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    CGFloat width = (CGRectGetWidth(self.view.bounds) - 30) / 2;
    ZYXMovieCollectionViewFlowLayout *layout = (ZYXMovieCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(width, 320);
}

#pragma mark -
#pragma mark Networking Request Methods

- (void)requestMovie
{
    [self.networkingLoadingViewController showLoadingView];
    self.containerView.alpha = 1;
    [self requestMoviesWithCompletionHandler:^(List *list, NSError *error) {
        if (error) {
            self.containerView.alpha = 1;
            [self.networkingLoadingViewController showErrorView];
        } else {
            if ([list.totalResults integerValue] == 0) {
                self.containerView.alpha = 1;
                [self.networkingLoadingViewController showNoContentView];
            } else {
                self.movies = list.movies;
//                if (list.totalPages > 1) {
//                    for (int i = 2; i <= list.totalPages; i++) {
//                        [self requestMoviesWithCompletionHandler:^(List *list, NSError *error) {
//                            if (error) {
//                                self.containerView.alpha = 1;
//                                [self.networkingLoadingViewController showErrorView];
//                            } else {
//                                if (list.totalResults == 0) {
//                                    self.containerView.alpha = 1;
//                                    [self.networkingLoadingViewController showNoContentView];
//                                } else {
//                                    self.containerView.alpha = 0;
//                                    NSMutableArray *mutableMovies = [self.movies mutableCopy];
//                                    [mutableMovies addObjectsFromArray:list.movies];
//                                    self.movies = mutableMovies;
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        [self.collectionView reloadData];
//                                    });
//                                }
//                        }
//                        }];
//                    }
//                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.containerView.alpha = 0;
                    [self.collectionView reloadData];
                });
            }
        }
    }];
}

- (void)requestMoviesWithCompletionHandler:(void(^)(List *list, NSError *error))completionHandler
{
    [self.page getMoviesWithIndex:self.page.index page:self.requestPage++ withCompletionHandler:completionHandler];
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
    return self.movies ? [self.movies count] : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYXMovieFlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if ([cell isKindOfClass:[ZYXMovieFlowCollectionViewCell class]]) {
        if ([self.movies[indexPath.item] isKindOfClass:[Movie class]]) {
            Movie *movie = (Movie *)self.movies[indexPath.item];
            if (movie) {
                
                if (movie.posterPath && [movie.posterPath length] > 0) {
                    NSURL *posterURL = [[ZYXTMDBClient sharedInstance] getImageUrl:movie.posterPath withSize:[ZYXTMDBClient sharedInstance].config.posterSizes[2]];
                    [cell.posterImageView sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"popcorn-film-party"]];
                } else {
                    cell.posterImageView.image = [UIImage imageNamed:@"popcorn-film-party"];
                }
                
                if (movie.title && [movie.title length] > 0) {
                    cell.titleLabel.text = movie.title;
                } else {
                    cell.titleLabel.hidden = YES;
                }
                if (movie.originalTitle && [movie.originalTitle length] != 0) {
                    cell.anotherTitleLabel.text = movie.originalTitle;
                } else {
                    cell.anotherTitleLabel.hidden = YES;
                }
                
                if (movie.voteAverage) {
                    cell.ratingCircle.currentValue = movie.voteAverage;
                } else {
                    cell.ratingCircle.currentValue = 0;
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
#pragma mark UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYXNavigationController *navigationController = (ZYXNavigationController *)[StoryBoardUtilities viewControllerForStoryboardName:@"MovieDetails" class:[ZYXNavigationController class]];
    ZYXMovieDetailsViewController *movieDetailViewController = (ZYXMovieDetailsViewController *)navigationController.viewControllers.firstObject;
    Movie *movie = self.movies[indexPath.item];
    NSLog(@"%ld", [movie.id integerValue]);
    movieDetailViewController.id = [movie.id integerValue];
    movieDetailViewController.MovieTitle = movie.title;
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark -
#pragma mark RefreshViewDelegate

- (void)refreshViewDidRefresh
{
    [self requestMovie];
}


@end
