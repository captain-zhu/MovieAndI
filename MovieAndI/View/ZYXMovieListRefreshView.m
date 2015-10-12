//
//  ZYXMovieListRefreshView.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/12.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXMovieListRefreshView.h"
#import "ZYXMovieDetailRefreshItem.h"

@interface ZYXMovieListRefreshView () <UIScrollViewDelegate>

@property (nonatomic) CGFloat sceneHeight;
@property (nonatomic) CGFloat progressPercentage;

@end

@implementation ZYXMovieListRefreshView{
    BOOL _isRefreshing;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.scrollView = [[UIScrollView alloc] init];
    }
    return self;
}

//自定义的初始化
- (instancetype)initWithFrame:(CGRect)frame ScrollView:(UIScrollView *)scollView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = scollView;
        self.clipsToBounds = YES;
        [self updateBackgroundColor];
        [self setupRefreshItems];
    }
    return self;
}

- (CGFloat)sceneHeight
{
    return 120.0f;
}

#pragma mark - 
#pragma mark Delegate Helper Methods

- (void)beginRefresh
{
    _isRefreshing = YES;
}

- (void)endRefresh
{
    _isRefreshing = NO;
}

#pragma mark -
#pragma mark Helper Methods

- (void)updateBackgroundColor
{
    CGFloat value = self.progressPercentage * 0.7 + 0.2;
    self.backgroundColor = [UIColor colorWithRed:value green:value blue:value alpha:1];
}

- (void)setupRefreshItems
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cinema"]];
    
    self.refreshItems = @[[[ZYXMovieDetailRefreshItem alloc] initWithView:imageView withCenterEnd:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(imageView.bounds)/2) withParallaxRatio:1 withSceneHeight:self.sceneHeight]];
    for (ZYXMovieDetailRefreshItem *refreshItem in self.refreshItems) {
        [self addSubview:refreshItem.view];
    }
}

- (void)updateRefreshItemsPosition
{
    for (ZYXMovieDetailRefreshItem *item in self.refreshItems) {
        [item updateViewPositionForPercentage:self.progressPercentage];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isRefreshing) {
        return;
    }
    CGFloat refreshViewVisibleHeight = MAX(0, -(scrollView.contentOffset.y + scrollView.contentInset.top));
    self.progressPercentage = MIN(1, refreshViewVisibleHeight / self.sceneHeight);
    
    [self updateBackgroundColor];
    [self updateRefreshItemsPosition];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (!_isRefreshing && self.progressPercentage == 1) {
        [self beginRefresh];
        [self.delegate refreshViewDidRefresh];
    }
}



















@end
