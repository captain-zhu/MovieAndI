//
//  ZYXMovieListRefreshView.h
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/12.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYXMovieListRefreshViewDelegate

- (void)refreshViewDidRefresh;

@end

@interface ZYXMovieListRefreshView : UIView

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *refreshItems;
@property (nonatomic, weak) id<ZYXMovieListRefreshViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame ScrollView:(UIScrollView *)scollView;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;

- (void)endRefresh;

@end
