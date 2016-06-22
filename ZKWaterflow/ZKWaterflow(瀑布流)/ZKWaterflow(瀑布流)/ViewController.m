//
//  ViewController.m
//  ZKWaterflow(瀑布流)
//
//  Created by 闫振奎 on 16/6/22.
//  Copyright © 2016年 TowMen. All rights reserved.
//

#import "ViewController.h"
#import "ZKWaterflowLayout.h"
#import "ZKShop.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ZKShopCell.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()<UICollectionViewDataSource, ZKWaterflowLayoutDelegate>
/** 所有的商品数据 */
@property (nonatomic, strong) NSMutableArray *shops;

@property (nonatomic, weak) UICollectionView *collectionView;


@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

static NSString * const ZKShopId = @"shop";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLayout];
    
    [self setupRefresh];
    
    
}

- (void)setupRefresh
{
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collectionView.header beginRefreshing];
    
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collectionView.footer.hidden = YES;
}

- (void)loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [ZKShop objectArrayWithFilename:@"1.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
        // 刷新数据
        [self.collectionView reloadData];
        [self.collectionView.header endRefreshing];
    });
}

- (void)loadMoreShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [ZKShop objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collectionView reloadData];
        
        [self.collectionView.footer endRefreshing];
    });
}

- (void)setupLayout
{
    // 创建布局
    ZKWaterflowLayout *layout = [[ZKWaterflowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKShopCell class]) bundle:nil] forCellWithReuseIdentifier:ZKShopId];
    
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.shops.count == 0;
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZKShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZKShopId forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.item];
    
    return cell;
}

#pragma mark - <ZKWaterflowLayoutDelegate>
//返回每个cell的高度
- (CGFloat)waterflowLayout:(ZKWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth
{
    ZKShop *shop = self.shops[index];
    return itemWidth * shop.h / shop.w;
}

//每行的最小距离
- (CGFloat)rowMarginInWaterflowLayout:(ZKWaterflowLayout *)waterflowLayout
{
    return 10;
}
//有多少列
- (CGFloat)columnCountInWaterflowLayout:(ZKWaterflowLayout *)waterflowLayout
{
    if (self.shops.count <= 50) return 2;
    return 3;
}

//内边距
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZKWaterflowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(20, 10, 30, 10);
}


@end
