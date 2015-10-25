//
//  ZYXCollectionViewLayout.m
//  MovieAndI
//
//  Created by zhu yongxuan on 15/10/7.
//  Copyright © 2015年 zhu yongxuan. All rights reserved.
//

#import "ZYXCollectionViewLayout.h"


CGFloat const standardHeight = 100;
CGFloat const featuredHeight = 280;

@interface ZYXCollectionViewLayout()

@property (nonatomic, strong) NSMutableArray *cache;
@property (nonatomic) NSInteger featureItemIndex;
@property (nonatomic) CGFloat nextItemPercentageOffset;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) NSInteger numberOfItems;

@end

@implementation ZYXCollectionViewLayout

#pragma mark - Lazy init
- (NSMutableArray *)cache
{
    if (!_cache) {
        _cache = [[NSMutableArray alloc]init];
    }
    return _cache;
}

- (CGFloat)dragOffset
{
    return 180.0f;
}

//返回现在feature cell的编号
- (NSInteger)featureItemIndex
{
    _featureItemIndex = MAX(0, (int)self.collectionView.contentOffset.y / (int)self.dragOffset);
    return _featureItemIndex;
}

//返回feature cell下一个cell已经滑动距离占总需滑动距离的比例
- (CGFloat)nextItemPercentageOffset
{
    _nextItemPercentageOffset = (self.collectionView.contentOffset.y / self.dragOffset) - (CGFloat)(self.featureItemIndex);
    return _nextItemPercentageOffset;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.collectionView.bounds);
}

- (CGFloat)height
{
    CGRectGetHeight(self.collectionView.bounds);
    return CGRectGetHeight(self.collectionView.bounds);
}

- (NSInteger)numberOfItems
{
    return [self.collectionView numberOfItemsInSection:0];
}

#pragma mark - UICollectionViewLayout

- (CGSize)collectionViewContentSize
{
    CGFloat contentHeight = (self.numberOfItems * self.dragOffset) + (self.height - self.dragOffset);
    return CGSizeMake(self.width, contentHeight);
}

- (void)prepareLayout
{
    self.cache = nil;
    
    CGRect frame = CGRectZero;
    CGFloat y = 0;
    
    for (int i = 0; i < self.numberOfItems; ++i) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.zIndex = i;
        CGFloat cellHeight = standardHeight;
        if (indexPath.item == self.featureItemIndex) {
            CGFloat yOffset = standardHeight * self.nextItemPercentageOffset;
            y = self.collectionView.contentOffset.y - yOffset;
            cellHeight = featuredHeight;
        } else if (indexPath.item == (self.featureItemIndex + 1) && indexPath.item != self.numberOfItems) {
            CGFloat maxY = y + standardHeight;
            cellHeight = standardHeight + MAX((featuredHeight - standardHeight) * self.nextItemPercentageOffset, 0);
            y = maxY - cellHeight;
        }
        frame = CGRectMake(0, y, self.width, cellHeight);
        attributes.frame = frame;
        [self.cache addObject:attributes];
        y = CGRectGetMaxY(frame);
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [[NSMutableArray alloc] init];
    for (id item in self.cache) {
        if ([item isKindOfClass:[UICollectionViewLayoutAttributes class]]) {
            UICollectionViewLayoutAttributes *attributes = (UICollectionViewLayoutAttributes *)item;
            if (CGRectIntersectsRect(attributes.frame, rect)) {
                [layoutAttributes addObject:attributes];
            }
        }
    }
    return layoutAttributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    NSInteger itemIndex = round(proposedContentOffset.y / self.dragOffset);
    CGFloat yOffset = itemIndex * self.dragOffset;
    return CGPointMake(0, yOffset);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
