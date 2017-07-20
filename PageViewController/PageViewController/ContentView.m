//
//  ContentView.m
//  PageViewController
//
//  Created by Justin on 2017/7/19.
//  Copyright © 2017年 jerei. All rights reserved.
//

#import "ContentView.h"

@interface ContentView () <UICollectionViewDataSource>
@end

@implementation ContentView
#pragma mark - 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ContentCellID"];
    }
    return _collectionView;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCellID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIViewController *childView = [[UIViewController alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(100, 100, 100, 100);
    label.text = self.contentArray[indexPath.row];
    [childView.view addSubview:label];
    [cell.contentView addSubview:childView.view];
    return cell;
}

@end
