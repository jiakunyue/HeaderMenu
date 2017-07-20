//
//  ViewController.m
//  PageViewController
//
//  Created by Justin on 2017/7/19.
//  Copyright © 2017年 jerei. All rights reserved.
//

#import "ViewController.h"
#import "HeaderView.h"
#import "ContentView.h"

@interface ViewController () <HeaderViewDelegate, UICollectionViewDelegate>
@property (nonatomic, strong) ContentView *contentView;
@property (nonatomic, strong) HeaderView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [self setupUI];
    
    [super viewDidLoad];
}

#pragma mark - 页面布局
- (void)setupUI {
    [self setupHeaderView];
    
    [self setupContentView];
}

- (void)setupContentView {
    ContentView *contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    contentView.contentArray = [NSMutableArray arrayWithArray:@[@"推荐",@"热点",@"科技",@"体育",@"视频",@"要闻",@"时政"]];//,@"时政",@"美女",@"搞笑",@"娱乐"
    contentView.collectionView.delegate = self;
    [self.view addSubview:contentView];
    
    self.contentView = contentView;
}

- (void)setupHeaderView {
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    headerView.menuArray = [NSMutableArray arrayWithArray:@[@"推荐",@"热点",@"科技",@"体育",@"视频",@"要闻",@"时政"]];
    headerView.delegate = self;
    [self.view addSubview:headerView];
    
    self.headerView = headerView;
}

#pragma mark - 代理
- (void)menuBtnClickAtIndex:(NSInteger)index {
    [self.contentView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [self.contentView.collectionView indexPathForItemAtPoint:scrollView.contentOffset];
    [self.headerView setselectedIndex:indexPath.row];
}
@end
