//
//  SNCollectionLayout.m
//  瀑布流
//
//  Created by Snake on 2019/4/29.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNCollectionLayout.h"

@implementation SNCollectionLayout
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *_layoutArr;
    NSMutableArray *_originYArr;
    NSInteger _collectionViewRowCount;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        _layoutArr = [NSMutableArray array];
        _originYArr = [NSMutableArray array];
        _collectionViewRowCount = 3;
    }
    return self;
}

- (void)prepareLayout {
    
    // 准备数据 对每一个cell的布局进行初始化
    [_layoutArr removeAllObjects];
    [_originYArr removeAllObjects];
    //
    for (int i = 0; i < _collectionViewRowCount; i++) {
        [_originYArr addObject:@(0)];
    }
    //
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < cellCount; i++) {
        // 处理每一个cell的布局属性
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        //
        [_layoutArr addObject:attributes];
    }
    
}

// 可以用自己的
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //
    float cellSizeWidth = [UIScreen mainScreen].bounds.size.width / _collectionViewRowCount;
    // 通过indexPath 算出cell相应高度
    float cellSizeHeight = 50 + arc4random_uniform(100);
    
    float cellX = cellSizeWidth * (indexPath.item % _collectionViewRowCount);
    
    float cellY = [_originYArr[indexPath.item % 3] floatValue];
    _originYArr[indexPath.item % 3] = @(cellY + cellSizeHeight);
    
    //
    attributes.frame = CGRectMake(cellX, cellY, cellSizeWidth, cellSizeHeight);
    
    //
    return attributes;
}

- (CGSize)collectionViewContentSize {
    //
    float maxHeight = [_originYArr[0] floatValue];
    for (int i = 0; i < _collectionViewRowCount; i++) {
        if (maxHeight < [_originYArr[i] floatValue]) {
            maxHeight = [_originYArr[i] floatValue];
        }
    }
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, maxHeight);
    //
    return size;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //
    return _layoutArr;
}

@end
