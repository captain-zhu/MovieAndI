//
//  ZTXSearchResultTableViewController.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/15.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXSearchResultTableViewController.h"
#import "Movie.h"
#import "UIImageView+WebCache.h"
#import "ZYXTMDBClient.h"
#import "ZYXSearchResultTableViewCell.h"

static NSString * const searchCellReuseIdentifier = @"SearchResultCell";

@interface ZYXSearchResultTableViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate>

@property (nonatomic, strong) NSURLSessionDataTask *searchTask;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *movies;

@end

@implementation ZYXSearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    recognizer.numberOfTapsRequired = 1;
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Action

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchTask) {
        [self.searchTask cancel];
    }
    
    if ([searchText length] == 0) {
        self.movies = nil;
        [self.tableView reloadData];
        return;
    }
    
    self.searchTask = [[ZYXTMDBClient sharedInstance] getMoviesForSearchString:searchText WithCompletionHandler:^(List *list, NSError *error) {
        self.searchTask = nil;
        if (list && [list.totalResults integerValue] > 0) {
            self.movies = list.movies;
            [self.tableView reloadData];
        }
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.movies)? [self.movies count] : 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"creat Cell");
    if ([tableView dequeueReusableCellWithIdentifier:searchCellReuseIdentifier forIndexPath:indexPath]) {
        NSLog(@"custom cell");
    }
    ZYXSearchResultTableViewCell *cell = (ZYXSearchResultTableViewCell *)[tableView dequeueReusableCellWithIdentifier:searchCellReuseIdentifier forIndexPath:indexPath];
    if (self.movies && [self.movies count] > 0) {
        if ([self.movies[indexPath.row] isKindOfClass:[Movie class]]) {
            Movie *movie = (Movie *)self.movies[indexPath.row];
            NSLog(@"%d %@", indexPath.row, movie.title);
            
            if (movie.title && [movie.title length] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.titleLabel.text = movie.title;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.titleLabel.text = @"未知名字";
                });
            }
            
            if (movie.releaseDate && [movie.releaseDate length] > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.subTitleLabel.text = movie.releaseDate;
                });
            } else {
                if (movie.originalTitle && [movie.originalTitle length] > 0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.subTitleLabel.text = movie.originalTitle;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell.subTitleLabel.text = @"电影";
                    });
                }
            }
            
            if (movie.posterPath) {
                NSURL *posterURL = [[ZYXTMDBClient sharedInstance] getImageUrl:movie.posterPath withSize:[ZYXTMDBClient sharedInstance].config.posterSizes[0]];
                [cell.posterImageView sd_setImageWithURL:posterURL placeholderImage:[UIImage imageNamed:@"film_512"]];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = [UIImage imageNamed:@"film_512"];
                });
            }
            
            if (movie.voteAverage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.scoreLabel.text = [NSString stringWithFormat:@"%0.1f/10", movie.voteAverage];
                    cell.starRatingView.value = movie.voteAverage;
                    cell.starRatingView.hidden = NO;
                });
            }
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.titleLabel.text = @"抱歉，没有搜索到您想找的电影";
        });
        
    }
    
    return cell;
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return [self.searchBar isFirstResponder];
}

@end
